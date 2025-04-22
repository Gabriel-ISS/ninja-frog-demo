extends CanvasLayer


func _on_start_game_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/SelectLevelScreen/select_level_screen.tscn")


func _on_exit_btn_pressed() -> void:
	OS.kill(OS.get_process_id())
