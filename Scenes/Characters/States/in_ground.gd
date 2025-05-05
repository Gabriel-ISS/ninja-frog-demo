extends State

@export var air_state: State
@export var dash_state: State
@export var step_audio: AudioStreamPlayer
@export var jump_audio: AudioStreamPlayer
@export var ice_ray_cast: RayCast2D
@export var slide_paticles: CPUParticles2D

const SLIDE_DELTA_MOVE_TOWARD = 1

func on_enter():
	set_delta_move_toward()
	sprite.play("idle")


func process_state(_delta):
	# run and iddle
	var selected_direction = Input.get_axis("move_left", "move_right")
	if selected_direction:
		sprite.play("run")
		if not step_audio.playing:
			step_audio.play()
	else:
		sprite.play("idle")
	
	# fall
	if not character.is_on_floor():
		next_state = air_state
	
	# slide
	set_delta_move_toward()


func set_delta_move_toward():
	if ice_ray_cast.is_colliding():
		
		var running = bool(Input.get_axis("move_left", "move_right"))
		var direction = 1 if character.velocity.x > 0 else -1
		var character_v = abs(character.velocity.x)
		
		# particle velocity
		var min_particle_v = clamp(character_v, 10, 50)
		slide_paticles.initial_velocity_min = min_particle_v
		slide_paticles.initial_velocity_max = min_particle_v + 20
		
		var emit_direction = direction / (2000 / character_v)
		print(emit_direction)
		slide_paticles.direction.x = emit_direction * -1
		slide_paticles.direction.y = abs(emit_direction) * -10
		slide_paticles.emitting = !running and character_v > 0
		delta_move_toward = SLIDE_DELTA_MOVE_TOWARD
	else:
		slide_paticles.emitting = false
		delta_move_toward = DEFAULT_DELTA_MOVE_TOWARD


func on_input(event: InputEvent):
	if event.is_action_pressed("jump"):
		character.velocity.y = jump_speed
		jump_audio.play()
		next_state = air_state
	elif event.is_action_pressed("dash"):
		next_state = dash_state


func on_exit():
	slide_paticles.emitting = false
