extends AnimatableBody2D

const FALLING_SPEED = 200
const ELEVATE_SPEED = 50

var falling = false
var original_height = 0

func _ready() -> void:
	original_height = position.y

func _physics_process(delta: float) -> void:
	if falling:
		position.y += FALLING_SPEED * delta
	elif position.y > original_height:
		position.y -= ELEVATE_SPEED * delta

func _on_player_checker_body_entered(_body: Node2D) -> void:
	falling = true


func _on_player_checker_body_exited(_body: Node2D) -> void:
	falling = false
