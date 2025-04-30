@tool
extends Node2D

class_name Fruit

@export_enum(
	'apple', 
	'banana', 
	'cherry', 
	'kiwy', 
	'melon', 
	'orange', 
	'pineapple', 
	'strawberry'
) var fruit_type: String = 'apple':
	set(value):
		fruit_type = value
		$AnimatedSprite.animation = value

@onready var animated_sprite = $AnimatedSprite
@onready var collect_sound = $Collect

var collected = false

func _ready() -> void:
	if not Engine.is_editor_hint():
		collected = false
		animated_sprite.play(fruit_type)

func _on_collect_area_body_entered(body: Node2D) -> void:
	if collected: return
	if body is Character:
		var fruit_points = GeneralRules.POINTS[fruit_type]
		body.addPoints(fruit_points)
		collect_sound.play()
		animated_sprite.play('collected')

func _on_animations_animation_finished() -> void:
	queue_free()
