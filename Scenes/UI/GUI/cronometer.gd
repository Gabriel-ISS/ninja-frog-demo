class_name Cronometer extends Node

var _stoped = false
var current_value = 0:
	get():
		if not _stoped:
			var now = Time.get_ticks_msec()
			current_value += now - _start_time
			_start_time = now
		return current_value

var _start_time = 0


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS


func start():
	_stoped = false
	_start_time = Time.get_ticks_msec()


func stop() -> int:
	_stoped = true
	current_value += Time.get_ticks_msec() - _start_time
	return current_value


func reset():
	current_value = 0
