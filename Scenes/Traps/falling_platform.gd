extends AnimatableBody2D

const FALLING_SPEED = 200

var falling = false

func _process(delta: float) -> void:
	if falling:
		position.y += FALLING_SPEED * delta

func _on_player_checker_body_entered(_body: Node2D) -> void:
	falling = true
