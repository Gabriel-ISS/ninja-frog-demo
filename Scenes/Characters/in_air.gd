extends State

class_name AirState

@export var die_state: State
@export var dash_state: State
@export var ground_state: State
@export var shuriken_state: State
@export var wall_climb_state: State
@export var double_jump_state: State
@export var coyote_timer: Timer
@export var stiky_wall_ray_cast: RayCast2D

var leaved_floor = false
var coyote_jump_done = false
var can_double_jump = true

func on_enter():
	coyote_timer.start()


func process_state(_delta):
	handle_back_to_ground()
	handle_animations()
	handle_climb_wall()
	handle_map_fall()
	
	
func on_input(event):
	if event.is_action_pressed("jump"):
		if not coyote_timer.is_stopped() and not coyote_jump_done:
			coyote_jump_done = true
			character.velocity.y = JUMP_VELOCITY
		elif can_double_jump:
			can_double_jump = false
			next_state = double_jump_state
	elif event.is_action_pressed("shuriken"):
		next_state = shuriken_state
	elif event.is_action_pressed("dash"):
		next_state = dash_state
	
	
func handle_back_to_ground():
	if character.is_on_floor():
		coyote_jump_done = false
		can_double_jump = true
		next_state = ground_state
	
	
func handle_animations():
	if character.velocity.y < 0:
		sprite.play("jump")
	else:
		sprite.play("fall")
	
	
func handle_climb_wall():
	if stiky_wall_ray_cast.is_colliding():
		next_state = wall_climb_state
	
	
func handle_map_fall():
	if character.position.y > GeneralRules.DEADLY_Y_POSITION:
		next_state = die_state
	
