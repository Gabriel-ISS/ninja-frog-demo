extends State

@export var ground_state: State
@export var air_state: State
@export var die_state: State
@export var damage_audio: AudioStreamPlayer

func on_enter():
	character.lose_life()
	invencivility = true
	
	if (character._lifes > 0):
		sprite.play("hit")
		damage_audio.play()
	else:
		next_state = die_state


func on_sprite_animation_finished(_animation):
	next_state = ground_state if character.is_on_floor() else air_state


func on_exit():
	invencivility = false
