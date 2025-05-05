class_name EndLevelMenu extends Panel

@export var _total_points_label: Label
@export var _time_label: Label
@export var _record_time_label: Label
@export var _next_level_btn: Button

func _ready() -> void:
	visible = false
	_next_level_btn.visible = GeneralRules.current_level != GeneralRules.LEVELS


func set_points(won: int, total: int):
	_total_points_label.text = 'Points: {0} of {1}'.format([
		str(won),
		str(total)
	])


func set_time(time: int):
	_time_label.text = 'Time: ' + _ms_to_readable(time)


func set_record_time(time: int):
	_record_time_label.text = 'Best time: ' + _ms_to_readable(time)


func _ms_to_readable(ms: int) -> String:
	var total_seconds = ms / 1000.0
	var milliseconds = ms % 1000
	var seconds = int(total_seconds) % 60
	var total_minutes = total_seconds / 60
	var minutes = int(total_minutes) % 60
	
	return "{minutes}:{seconds}.{milliseconds}".format({
		minutes = str(minutes).pad_zeros(2),
		seconds = str(seconds).pad_zeros(2),
		milliseconds = str(milliseconds).pad_zeros(3)
	})


func _on_next_level_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	GeneralRules.current_level += 1
	tree.change_scene_to_file('res://Scenes/Levels/level_' + str(GeneralRules.current_level) + '.tscn')


func _on_try_again_pressed() -> void:
	get_tree().reload_current_scene()


func _on_back_to_menu_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	tree.change_scene_to_file('res://Scenes/UI/start_screen.tscn')
