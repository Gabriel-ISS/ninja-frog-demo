extends State

@export var air_state: State
@export var ground_state: State
@export var dash_sound: AudioStreamPlayer
@export var particles: DashParticles
@export var invencivility_timer: Timer

const DASH_VELOCITY = 900
var direction = 1

func on_enter():
	invencivility = true
	direction = -1 if sprite.flip_h else 1
	character.velocity.x = DASH_VELOCITY * direction
	sprite.play("dash")
	dash_sound.play()
	particles.flip_h = sprite.flip_h
	particles.emitting = true


func on_sprite_animation_finished(_animation_name):
	if character.is_on_floor():
		delta_move_toward = 30
		next_state = ground_state
	else:
		delta_move_toward = 20
		next_state = air_state


func on_exit():
	invencivility = false
	particles.emitting = false
