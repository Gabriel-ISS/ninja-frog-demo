extends Control


@export var cronometer: Cronometer
@export_category('Private')
@export var _computer_controls: Label


func _ready() -> void:
	visible = false
	get_tree().paused = false
	
	_computer_controls.visible = !DisplayServer.is_touchscreen_available()


func _on_resume_pressed() -> void:
	cronometer.start()
	visible = false
	get_tree().paused = false


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_back_to_menu_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	tree.change_scene_to_file("res://Scenes/UI/start_screen.tscn")
