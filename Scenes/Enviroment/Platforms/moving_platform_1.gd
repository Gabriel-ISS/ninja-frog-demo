extends AnimatableBody2D

func _process(_delta: float) -> void:
	global_position = get_parent().global_position
