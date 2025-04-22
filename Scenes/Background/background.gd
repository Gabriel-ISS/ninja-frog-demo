@tool
extends Node2D

@export_enum(
	'Forest',
	'Flower',
	'Mushroom',
	'Magic'
)
var bg: String:
	set(value):
		bg = value
		var path = "res://Scenes/Background/" + bg.to_lower() + "_background.tscn"
		var Bg: PackedScene = load(path)
		add_child(Bg.instantiate())
