@tool
extends Node2D

@export_enum(
	'apple', 
	'banana', 
	'cherry', 
	'kiwy', 
	'melon', 
	'orange', 
	'pineapple', 
	'strawberry'
) var fruitType: String = 'apple':
	set(value):
		fruitType = value
		$AnimatedSprite.animation = value

@onready var animated_sprite = $AnimatedSprite
@onready var collect_sound = $Collect

var collected = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Engine.is_editor_hint():
		collected = false
		animated_sprite.play(fruitType)

func _on_collect_area_body_entered(body: Node2D) -> void:
	if collected: return
	if body is Character:
		var fruitPoints = GeneralRules[fruitType + 'Points']
		body.addPoints(fruitPoints)
		collect_sound.play()
		animated_sprite.play('collected')

func _on_animations_animation_finished() -> void:
	queue_free()
