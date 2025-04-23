extends CharacterBody2D

@export var SPEED = 200

const CHECKER_TARGET_X = 24

@onready var wall_checker = $WallChecker
@onready var ground_checker = $GroundChecker

var move_direction = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	velocity.x = SPEED * move_direction
	
	if (wall_checker.is_colliding() or not ground_checker.is_colliding()):
		move_direction *= -1
		ground_checker.position.x = CHECKER_TARGET_X * move_direction
		wall_checker.target_position.x = CHECKER_TARGET_X * move_direction

	move_and_slide()
