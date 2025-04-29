extends Node

const DEBUG_PLAYER = false

const LEVELS = 4
const INITIAL_LIFES = 3
const DEADLY_Y_POSITION = 1000

const applePoints = 1
const bananaPoints = 2
const cherryPoints = 3
const kiwyPoints = 4
const melonPoints = 5
const orangePoints = 6
const pineapplePoints = 7
const strawberryPoints = 8

var current_level = 0


const data_file_path = "user://savegame.save"
var default_data = {
	'last_completed_level': 0,
	'records': {}
}


func save_data(data) -> void:
	var file = FileAccess.open(data_file_path, FileAccess.WRITE)
	var json_data = JSON.stringify(data)
	file.store_line(json_data)

func get_data():
	if not FileAccess.file_exists(data_file_path):
		save_data(default_data)
		return default_data
	var file = FileAccess.open(data_file_path, FileAccess.READ)
	var json_data = file.get_line()
	var data = JSON.parse_string(json_data)
	return data

var _saved_data = get_data()

var last_completed_level = _saved_data['last_completed_level']:
	set(value):
		last_completed_level = value
		_saved_data['last_completed_level'] = value
		save_data(_saved_data)

var _records = _saved_data['records']

func get_record(level: int):
	if not level in _records:
		return null
	return _records[level]
	
func set_record(level: int, record: int):
	_records[level] = record
	_saved_data['records'] = _records
	save_data(_saved_data)
