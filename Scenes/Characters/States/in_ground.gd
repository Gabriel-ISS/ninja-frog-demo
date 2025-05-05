extends State

@export var air_state: State
@export var dash_state: State
@export var step_audio: AudioStreamPlayer
@export var jump_audio: AudioStreamPlayer
@export var slippery_ray_cast: RayCast2D

const SLIDE_DELTA_MOVE_TOWARD = 2

func on_enter():
	sprite.play("idle")

func process_state(_delta):
	# run and iddle
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		sprite.play("run")
		if not step_audio.playing:
			step_audio.play()
	else:
		sprite.play("idle")
	
	# fall
	if not character.is_on_floor():
		next_state = air_state
	
	# resbalar (slide?)
	if slippery_ray_cast.is_colliding():
		DELTA_MOVE_TOWARD = SLIDE_DELTA_MOVE_TOWARD
	else:
		DELTA_MOVE_TOWARD = DEFAULT_DELTA_MOVE_TOWARD
	

func on_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		character.velocity.y = JUMP_VELOCITY
		jump_audio.play()
		next_state = air_state
	elif event.is_action_pressed("dash"):
		next_state = dash_state
