extends Panel

class_name EndLevelMenu

@onready var total_points_label: Label = $CenterContainer/VBoxContainer/Points
@onready var record_label: Label = $CenterContainer/VBoxContainer/Record
@onready var next_level_btn: Button = $CenterContainer/VBoxContainer/NextLevel

var total_points = 0:
	set(value):
		total_points = value
		total_points_label.text = 'Total points: ' + str(value)

var record = 0:
	set(value):
		record = value
		record_label.text = 'Record: ' + str(value)

func _ready() -> void:
	visible = false
	next_level_btn.visible = GeneralRules.current_level != GeneralRules.LEVELS


func _on_next_level_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	GeneralRules.current_level += 1
	tree.change_scene_to_file('res://Scenes/Levels/level_' + str(GeneralRules.current_level) + '.tscn')


func _on_back_to_menu_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	tree.change_scene_to_file('res://Scenes/UI/start_screen.tscn')
