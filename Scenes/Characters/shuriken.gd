extends Node2D

const GRAVITY = 9.8

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite
@onready var hit_sound = $HitSound

var initial_velocity = Vector2(0, 0)
var velocity = Vector2(450, -200)
var is_flip = false


func _ready() -> void:
	velocity += initial_velocity
	if is_flip:
		velocity.x *= -1
		animation_player.speed_scale *= -1
	
	
func _process(delta: float) -> void:
	velocity.y += GRAVITY
	
	handle_impulse(delta)
	handle_die_on_fall()
	
	
func handle_impulse(delta: float):
	position += velocity * delta
	
	
func handle_die_on_fall():
	if position.y > GeneralRules.DEADLY_Y_POSITION:
		queue_free()
	
	
func _on_hit_area_body_entered(_body: Node2D) -> void:
	velocity = Vector2(0, 0)
	animation_player.stop()
	animated_sprite.play("collide")
	hit_sound.play()


func _on_shuriken_animation_finished() -> void:
	queue_free()
