extends Node

# Administra el acceo a datos persistentes

const DATA_FILE_PATH = "user://savegame.save"
const CURRENT_DATA_VERSION = 3
const DEFAULT_DATA = {
	'_v': CURRENT_DATA_VERSION,
	'last_completed_level': 0,
	'records': {},
	'dificult_level': 1,
	'music_volume': 100,
	'effects_volume': 100,
	'controls_size': 100,
	'last_bg': 0,
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
		data['last_bg'] = 0
]

var _data = _get_data()

func _save() -> void:
	var file = FileAccess.open(DATA_FILE_PATH, FileAccess.WRITE)
	var json_data = JSON.stringify(_data)
	file.store_line(json_data)

func _get_data():
	if not FileAccess.file_exists(DATA_FILE_PATH):
		return DEFAULT_DATA.duplicate(true)
	
	var file = FileAccess.open(DATA_FILE_PATH, FileAccess.READ)
	var json_data = file.get_line()
	var data = JSON.parse_string(json_data)
	
	if not data:
		printerr('JSON data corrupted')
		return DEFAULT_DATA.duplicate(true)
	
	_update_data(data)
	return data

func _update_data(data: Dictionary):
	var i = data['_v'] - 1
	while data['_v'] < CURRENT_DATA_VERSION:
		DATA_UPDATERS[i].call(data)
		i += 1
	_save()

func _get(property: StringName):
	return _data[property]

func _set(property: StringName, variant) -> bool:
	var exeptions = ['_v', 'records']
	if not property in _data or exeptions.find(property) != -1:
		printerr("'{}' is not a valid property".format(property))
		return false
	
	_data[property] = variant
	_save()
	return true

func _get_property_list():
	return [
		{ "name": "dificult_level", "type": TYPE_INT },
		{ "name": "last_completed_level", "type": TYPE_INT },
	]

func get_record(level: int):
	var records = _data['records']	
	var str_level = str(level)
	if not str_level in records: return null
	return records[str_level]
	
func set_record(level: int, record: int):
	_data['records'][str(level)] = record
	_save()
