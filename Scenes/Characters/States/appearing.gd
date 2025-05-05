extends State

@export var ground_state: State

func on_enter():
	sprite.play("appair")
	character.lock_movement = true
	character.lock_direction = true

func on_sprite_animation_finished(_animation_name):
	next_state = ground_state

func on_exit():
	character.lock_movement = false
	character.lock_direction = false
