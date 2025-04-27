extends Node2D

@export var IMPULSE = 700

@onready var animated_sprite = $AnimatedSprite
@onready var impulse_sound = $Impulse

func _on_activation_area_body_entered(body: Node2D) -> void:
	animated_sprite.play("launch")
	body.velocity.y = -IMPULSE
	impulse_sound.play()
