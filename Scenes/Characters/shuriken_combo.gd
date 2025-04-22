extends State

@export var ground_state: State
@export var Shuriken: PackedScene

func on_enter():
	var shuriken = Shuriken.instantiate()
	var shuriken2 = Shuriken.instantiate()
	shuriken.position = character.position
	shuriken2.position = character.position
	shuriken.is_flip = sprite.flip_h
	shuriken2.is_flip = !sprite.flip_h
	character.add_sibling(shuriken)
	character.add_sibling(shuriken2)
	sprite.play("throw_shuriken")

func on_sprite_animation_finished(_animation):
	next_state = ground_state
