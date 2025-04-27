extends Node2D


const Chain: PackedScene = preload("res://Scenes/Traps/SpikeBall/one_chain.tscn")
const chain_spacing = 6

@export var VELOCITY: float = 1
@export var USE_MAX_DISTANCE = false
@export var MAX_DISTANCE: int = 80

@onready var rotate_animation = $RotateAnimation
@onready var floor_detection = $FloorChecker
@onready var safe_timer = $SafeTimer
@onready var spike_ball = $SpikedBall

var floor_detected = false
var floor_detection_initial_y = 0


func _ready() -> void:
	rotate_animation.speed_scale = VELOCITY
	floor_detection_initial_y = floor_detection.target_position.y
	safe_timer.start()


func _process(_delta: float) -> void:
	# esperar a que cargue el mapa
	if not safe_timer.is_stopped(): return
	
	# detect floor
	if not floor_detected:
		floor_detection.target_position.y += chain_spacing
		if floor_detection.is_colliding() or USE_MAX_DISTANCE and floor_detection.target_position.y >= MAX_DISTANCE:
			floor_detection.target_position.y -= chain_spacing
			floor_detected = true
			init_spike_ball()


func init_spike_ball():
	var number_of_chains = (floor_detection.target_position.y - floor_detection_initial_y) / chain_spacing
	spike_ball.position.y += (number_of_chains - 1) * chain_spacing
	for i in range(number_of_chains):
		var ring = Chain.instantiate()
		ring.position = Vector2(0, i * chain_spacing)
		self.add_child(ring)
	
# start rotation
func _on_safe_timer_timeout() -> void:
	rotate_animation.play("regular_move")
	
# change direction
func _on_ball_area_body_entered(_body: Node2D) -> void:
	rotate_animation.speed_scale *= -1
