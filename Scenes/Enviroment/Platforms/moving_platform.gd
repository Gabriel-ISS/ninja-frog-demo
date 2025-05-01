extends Path2D

@export var velocity: float = 1

@onready var platform: AnimatableBody2D = $PathFollow2D/Platform
@onready var path_follow: PathFollow2D = $PathFollow2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS if visible else PROCESS_MODE_DISABLED
	
	animation_player.speed_scale = velocity

func _process(_delta: float) -> void:
	platform.global_position = path_follow.global_position
