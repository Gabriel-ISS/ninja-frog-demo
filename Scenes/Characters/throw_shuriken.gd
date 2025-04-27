extends State

@export var ground_state: State
@export var air_state: State
@export var Shuriken: PackedScene

func on_enter():
	var shuriken = Shuriken.instantiate()
	shuriken.position = character.position
	shuriken.initial_velocity = character.velocity
	shuriken.is_flip = sprite.flip_h
	character.add_sibling(shuriken)
	sprite.play("throw_shuriken")

func on_sprite_animation_finished(_animation):
	next_state = ground_state if character.is_on_floor() else air_state
