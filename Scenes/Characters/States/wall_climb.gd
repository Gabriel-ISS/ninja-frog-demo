extends State

@export var air_state: AirState
@export var jump_audio: AudioStreamPlayer
@export var front_ray_cast: FronRayCast

var lock_player = true


func on_enter():
	character.lock_movement = true
	character.lock_direction = true
	lock_player = true
	character.velocity.y = 0
	sprite.play("wall_climb")


func process_state(_delta):
	handle_fall()
	if lock_player:
		character.velocity.y = 5


func handle_fall():
	if not front_ray_cast.is_colliding():
		next_state = air_state


func on_input(event):
	if event.is_action_pressed("jump"):
		var direction := Input.get_axis("move_left", "move_right")
		lock_player = false
		if direction:
			character.velocity.x = direction * speed
			character.velocity.y = jump_speed
			sprite.play("jump")
			jump_audio.play()
		air_state.can_double_jump = true
		next_state = air_state


func on_exit():
	character.lock_movement = false
	character.lock_direction = false
