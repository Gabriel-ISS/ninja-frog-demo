extends Node

# Administra el acceo a datos persistentes

# ordenado de mas reciente a mas antiguo
const DATA_FILE_PATHS = [
	"user://data.json",
	"user://savegame.save",
]
const CURRENT_DATA_FILE_PATH = DATA_FILE_PATHS[0]
const CURRENT_DATA_VERSION = 5
const DEFAULT_DATA = {
	_v = CURRENT_DATA_VERSION,
	last_completed_level = 0,
	# {level: time_ms}
	records = {},
	dificult_level = 1,
	music_volume = 100,
	effects_volume = 100,
	controls_size = 100,
	last_bg = 0,
}
var DATA_UPDATERS = [
	func (data: Dictionary):
		data['_v'] = 1
		data['last_completed_level'] = 0
		data['records'] = {},
	func (data: Dictionary):
		#'_v': 1,
		#'last_completed_level': 0,
		#'records': {}
		data['_v'] = 2
		data['dificult_level'] = 1
		data['music_volume'] = 100
		data['effects_volume'] = 100
		data['controls_size'] = 100,
	func (data: Dictionary):
		#'_v': 2,
		#'last_completed_level': 0,
		#'records': {},
		#'dificult_level': 1,
		#'music_volume': 100,
		#'effects_volume': 100,
		#'controls_size': 100,
		data['_v'] = 3
		data['last_bg'] = 0,
	func (data: Dictionary):
		data['_v'] = 4,
	func (data: Dictionary):
		data['_v'] = 5
		var records: Dictionary = data['records']
		for level in records.keys():
			data['records'][level] = 0
]

var _data = DEFAULT_DATA


func _ready() -> void:
	load_game()


func _get_property_list():
	var property_list: Array[Dictionary] = []
	for key in DEFAULT_DATA:
		var value = DEFAULT_DATA[key]
		property_list.append({
			key: typeof(value)
		})
		
	return property_list


func _get(property: StringName):
	return _data[property]


func _set(property: StringName, variant) -> bool:
	var exeptions = ['_v', 'records']
	if not property in _data or exeptions.find(property) != -1:
		printerr("'{}' is not a valid property".format(property))
		return false
	
	_data[property] = variant
	save_game()
	return true


func _get_updated_data(deprecated_data: Dictionary):
	var d = deprecated_data
	var i = d['_v'] - 1
	while d['_v'] < CURRENT_DATA_VERSION:
		DATA_UPDATERS[i].call(d)
		i += 1
	return d


func _get_file_content_as_json(file_path):
	if not FileAccess.file_exists(file_path):
		return null
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json_data = file.get_as_text(true)
	var data = JSON.parse_string(json_data)
	
	if not data:
		printerr('JSON data corrupted')
		return null
	
	return data


# solo obtieene los datos, pueden no estar actualizados
func _get_saved_data_as_json():
	var i = 0
	for path in DATA_FILE_PATHS:
		var data = _get_file_content_as_json(path)
		
		if data and i != 0:
			DirAccess.remove_absolute(path)
		
		if data: return data
		
		i += 1
	
	return null


func reset_game():
	_data = DEFAULT_DATA.duplicate(true)
	save_game()


func load_game():
	var data = _get_saved_data_as_json()
	
	if not data:
		reset_game()
		return
	
	_data = _get_updated_data(data)
	save_game()


func save_game() -> void:
	var file = FileAccess.open(CURRENT_DATA_FILE_PATH, FileAccess.WRITE)
	var json_data = JSON.stringify(_data)
	file.store_line(json_data)


func get_record(level: int):
	var records = _data['records']	
	var str_level = str(level)
	if not str_level in records: return null
	return records[str_level]


func set_record(level: int, record: int):
	_data['records'][str(level)] = record
	save_game()
