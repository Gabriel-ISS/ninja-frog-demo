extends CharacterBody2D

const CHECKER_TARGET_X = 24
@export var SPEED = 200
@export var MAKE_STATIC = false
@export_category('Private')
@export var _wall_checker: RayCast2D
@export var _ground_checker: RayCast2D
@export var _ground_collision: CollisionShape2D

var move_direction = 1

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS if visible else PROCESS_MODE_DISABLED
	
	_ground_collision.disabled = MAKE_STATIC


func _physics_process(delta: float) -> void:
	if MAKE_STATIC: return
	
	# Add the gravity.
	if not is_on_floor(): velocity += get_gravity() * delta
	
	# move
	velocity.x = SPEED * move_direction
	
	handle_direction_change()
	move_and_slide()

func handle_direction_change():
	if (
			_wall_checker.is_colliding() or 
			not _ground_checker.is_colliding()
		):
			move_direction *= -1
			_ground_checker.position.x = CHECKER_TARGET_X * move_direction
			_wall_checker.target_position.x = CHECKER_TARGET_X * move_direction
