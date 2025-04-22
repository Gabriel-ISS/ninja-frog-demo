extends Control

func _ready() -> void:
	visible = false
	get_tree().paused = false


func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, value - 100)


func _on_soud_effect_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, value - 100)


func _on_back_to_menu_pressed() -> void:
	var tree = get_tree()
	tree.paused = false
	tree.change_scene_to_file("res://Scenes/UI/start_screen.tscn")
