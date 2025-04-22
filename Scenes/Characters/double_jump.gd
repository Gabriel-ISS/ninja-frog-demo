extends State

@export var air_state: State
@export var dash_state: State
@export var double_jump_audio: AudioStreamPlayer

const DOUBLE_JUMP_VELOCITY = -300

func on_enter():
	character.velocity.y = DOUBLE_JUMP_VELOCITY
	sprite.play("double_jump")
	double_jump_audio.play()

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed('dash'):
		next_state = dash_state

func on_sprite_animation_finished(_animation):
	next_state = air_state
