extends Node2D

const Chain: PackedScene = preload("res://Scenes/Traps/SpikeBall/one_chain.tscn")
const chain_spacing = 6

@export var VELOCITY: float = 1
@export var USE_MAX_DISTANCE = false
@export var MAX_DISTANCE: int = 80

@onready var rotate_animation = $RotateAnimation
@onready var floor_detection = $FloorChecker
@onready var spike_ball = $SpikedBall

var map_loaded = false
var floor_detected = false
var floor_detection_initial_y = 0

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS if visible else PROCESS_MODE_DISABLED
	
	rotate_animation.speed_scale = VELOCITY
	floor_detection_initial_y = floor_detection.target_position.y
	
	var tile_map: Node2D = get_parent().get_parent().get_node('TileMap')
	
	map_loaded = tile_map.is_node_ready()
	if not map_loaded: tile_map.connect(
		'ready', 
		func(): map_loaded = true
	)


func _process(_delta: float) -> void:
	if not map_loaded: return
	handle_floor_detection()

# detecta el suelo e inicializa la trampa
func handle_floor_detection():
	# mientras no se detecte el suelo
	if not floor_detected:
		# bajar el detector
		floor_detection.target_position.y += chain_spacing
		
		# si se detecto colision con el suelo o se alcazo el limite
		if floor_detection.is_colliding() or USE_MAX_DISTANCE and floor_detection.target_position.y >= MAX_DISTANCE:
			floor_detected = true
			
			# quitar una cadena de espacio para el margen
			floor_detection.target_position.y -= chain_spacing
			add_chains()
			rotate_animation.play("regular_move")


func add_chains():
	var number_of_chains = (floor_detection.target_position.y - floor_detection_initial_y) / chain_spacing
	spike_ball.position.y += (number_of_chains - 1) * chain_spacing
	for i in range(number_of_chains):
		var ring = Chain.instantiate()
		ring.position = Vector2(0, i * chain_spacing)
		add_child(ring)


func change_direction():
	rotate_animation.speed_scale *= -1


func _on_ball_area_body_entered(_body: Node2D) -> void:
	change_direction()
