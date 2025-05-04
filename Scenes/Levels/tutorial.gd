extends Node


@export var computer_tutorial: Control
@export var cellphone_tutorial: Control

func _ready() -> void:
	var has_touchscreen = DisplayServer.is_touchscreen_available()
	computer_tutorial.visible = !has_touchscreen
	cellphone_tutorial.visible = has_touchscreen
