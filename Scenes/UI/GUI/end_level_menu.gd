extends Panel

class_name EndLevelMenu

@onready var total_points_label: Label = $CenterContainer/VBoxContainer/Points
@onready var record_label: Label = $CenterContainer/VBoxContainer/Record
@onready var next_level_btn: Button = $CenterContainer/VBoxContainer/VBoxContainer/NextLevel


func _ready() -> void:
	visible = false
	next_level_btn.visible = GeneralRules.current_level != GeneralRules.LEVELS


func set_points(won: int, total: int):
	total_points_label.text = 'Points: {0} of {1}'.format([
		str(won),
		str(total)
	])


func set_record(record: int):
	record_label.text = 'Record: ' + str(record)


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
