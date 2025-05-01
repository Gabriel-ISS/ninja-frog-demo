extends Node2D

@export var IMPULSE = 700

@onready var animated_sprite = $AnimatedSprite
@onready var impulse_sound = $Impulse

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS if visible else PROCESS_MODE_DISABLED
	


func _on_activation_area_body_entered(body: Node2D) -> void:
	animated_sprite.play("launch")
	body.velocity.y = -IMPULSE
	impulse_sound.play()
