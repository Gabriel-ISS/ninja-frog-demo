extends CanvasLayer

@export var exit_btn: Button


func _ready() -> void:
	if OS.get_name() == 'Web':
		exit_btn.visible = false
		exit_btn.process_mode = Node.PROCESS_MODE_DISABLED


func _on_exit_btn_pressed() -> void:
	OS.kill(OS.get_process_id())
