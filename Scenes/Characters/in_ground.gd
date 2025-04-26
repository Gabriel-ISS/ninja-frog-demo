extends State

@export var air_state: State
@export var dash_state: State
@export var shuriken_state: State
@export var shuriken_combo_state: State
@export var step_audio: AudioStreamPlayer
@export var jump_audio: AudioStreamPlayer
@export var slippery_ray_cast: RayCast2D
@export var combo_timer: Timer

const SLIDE_DELTA_MOVE_TOWARD = 5

const shuriken_combo = "LeftRightUpDownF"
var current_combo = ""

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
	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right") or event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down") or event.is_action_pressed("shuriken"):
		if combo_timer.is_stopped(): combo_timer.start()
		if current_combo.length() < shuriken_combo.length():
			current_combo += event.as_text()
			if current_combo == shuriken_combo: 
				next_state = shuriken_combo_state
				return
	
	if event.is_action_pressed("jump"):
		character.velocity.y = JUMP_VELOCITY
		jump_audio.play()
		next_state = air_state
	elif event.is_action_pressed("shuriken"):
		next_state = shuriken_state
	elif event.is_action_pressed("dash"):
		next_state = dash_state


func _on_combo_timeout() -> void:
	current_combo = ""
