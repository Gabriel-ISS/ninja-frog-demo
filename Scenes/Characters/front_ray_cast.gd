extends RayCast2D

class_name FronRayCast

const FRON_RAY_CAST_SIZE = 12

var flip = false

func _ready() -> void:
	self.target_position.x = FRON_RAY_CAST_SIZE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if flip:
		self.target_position.x = -FRON_RAY_CAST_SIZE
	else:
		self.target_position.x = FRON_RAY_CAST_SIZE
