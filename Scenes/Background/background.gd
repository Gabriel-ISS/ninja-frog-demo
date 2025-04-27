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
		var path = "res://Scenes/Background/" + background.to_lower() + "_background.tscn"
		var Bg: PackedScene = load(path)
		add_child(Bg.instantiate())
