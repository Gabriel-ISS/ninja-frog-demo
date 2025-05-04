extends CanvasLayer


@export var dificulty_control: OptionButton
@export var controls_size_label: Label
@export var controls_size_control: HSlider


func _ready() -> void:
	dificulty_control.select(LocalStorage.dificult_level)
	
	# set touchscreen controls visivility
	var has_touchscreen = DisplayServer.is_touchscreen_available()
	controls_size_label.visible = has_touchscreen
	controls_size_control.visible = has_touchscreen
	
	var mode = Node.PROCESS_MODE_ALWAYS if has_touchscreen else Node.PROCESS_MODE_DISABLED
	controls_size_label.process_mode = mode
	controls_size_control.process_mode = mode


func _on_dificulty_level_item_selected(index: int) -> void:
	LocalStorage.dificult_level = index
	GeneralRules.initial_lifes = GeneralRules.LIFES_PER_DIFICULT_LEVEL[LocalStorage.dificult_level]


func _on_controls_size_value_changed(value: float) -> void:
	LocalStorage.controls_size = int(value)
