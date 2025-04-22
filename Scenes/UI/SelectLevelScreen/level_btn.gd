@tool

extends Button

const levels_path = "res://Scenes/Levels/level_"
@export var level: int = 0:
	set(value):
		level = value
		text = var_to_str(level)

func _pressed() -> void:
	GeneralRules.current_level = level
	get_tree().change_scene_to_file(levels_path + var_to_str(level) + ".tscn")
