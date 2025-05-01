extends CanvasLayer


@export var dificulty_control: OptionButton


func _ready() -> void:
	dificulty_control.select(LocalStorage.dificult_level)


func _on_dificulty_level_item_selected(index: int) -> void:
	LocalStorage.dificult_level = index
	GeneralRules.initial_lifes = GeneralRules.LIFES_PER_DIFICULT_LEVEL[LocalStorage.dificult_level]


func _on_controls_size_value_changed(value: float) -> void:
	LocalStorage.controls_size = int(value)
