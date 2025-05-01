extends Control

func _ready() -> void:
	visible = false
	get_tree().paused = false


func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_back_to_menu_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	tree.change_scene_to_file("res://Scenes/UI/start_screen.tscn")
