extends CanvasLayer

func _on_exit_btn_pressed() -> void:
	OS.kill(OS.get_process_id())
