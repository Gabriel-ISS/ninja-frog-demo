@tool
extends Node2D

@export_enum(
	'Forest',
	'Flower',
	'Mushroom',
	'Magic'
)
var background: String:
	set(value):
		background = value
		if not value:
			_current_bg.queue_free()
			return
		
		var path = "res://Scenes/Background/" + background.to_lower() + "_background.tscn"
		var Bg: PackedScene = load(path)
		_current_bg = Bg.instantiate()
		add_child(_current_bg)

var _current_bg: Background

func _on_visibility_changed() -> void:
	if _current_bg:
		_current_bg.visible = visible
