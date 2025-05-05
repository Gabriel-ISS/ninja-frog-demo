extends CharacterBody2D

class_name Character

@export var state_machine: StateMachine
@export var sprite: AnimatedSprite2D
@export var front_ray_cast: FronRayCast

var _lifes = GeneralRules.initial_lifes
var _points = 0

var lock_movement = false
var lock_direction = false

var gui: Gui


func _ready() -> void:
	if get_parent().has_node('Gui'):
		gui = get_parent().get_node('Gui')
	else:
		printerr("'Gui' not found")


func _physics_process(delta: float) -> void:
	velocity.y += state_machine.current_state.gravity * delta

	var direction := Input.get_axis("move_left", "move_right")
	set_direction(direction)
	horizontal_move(direction)
	move_and_slide()


func horizontal_move(direction):
	if direction:
		if not lock_movement:
			velocity.x = move_toward(
				velocity.x, 
				direction * state_machine.current_state.speed, 
				state_machine.current_state.delta_move_toward
			)
	else:
		velocity.x = move_toward(
			velocity.x, 
			0, 
			state_machine.current_state.delta_move_toward
		)


func set_direction(direction):
	if lock_direction: return
	if direction > 0:
		sprite.flip_h = false
		front_ray_cast.flip = false
	elif direction < 0:
		sprite.flip_h = true
		front_ray_cast.flip = true


func add_points(toAdd):
	_points += toAdd
	gui.set_points(_points)


func lose_life():
	if state_machine.current_state.invencivility: return
	_lifes -= 1
	gui.remove_life()
