extends MarginContainer

func _ready() -> void:
	# solo por si las dudas
	visible = true
	
	var prefered_scale = LocalStorage.controls_size / 100
	if prefered_scale == 1: return
	
	update_size(prefered_scale)
	get_viewport().connect(
		'size_changed', func (): update_size(prefered_scale)
	)


func update_size(prefered_scale: float):
	scale.x = prefered_scale
	scale.y = prefered_scale
	anchor_right = anchor_right / prefered_scale
