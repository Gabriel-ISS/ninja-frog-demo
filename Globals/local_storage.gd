extends Node

# Administra el acceo a datos persistentes

const DATA_FILE_PATH = "user://savegame.save"
const CURRENT_DATA_VERSION = 1
const DEFAULT_DATA = {
	'_v': CURRENT_DATA_VERSION,
	'last_completed_level': 0,
	'records': {}
}

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
	if data['_v'] < CURRENT_DATA_VERSION:
		return DEFAULT_DATA.duplicate(true)
	return data

var last_completed_level = _data['last_completed_level']:
	set(value):
		last_completed_level = value
		_data['last_completed_level'] = value
		_save()

var _records = _data['records']

func get_record(level: int):
	var str_level = str(level)
	if not str_level in _records:
		return null
	return _records[str_level]
	
func set_record(level: int, record: int):
	var str_level = str(level)
	_records[str_level] = record
	_data['records'] = _records
	_save()
