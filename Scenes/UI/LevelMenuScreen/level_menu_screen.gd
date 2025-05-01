extends CanvasLayer

const LevelBtn = preload("res://Scenes/UI/LevelMenuScreen/level_btn.tscn")

@export var levels_container: GridContainer

func _ready() -> void:
	for child in levels_container.get_children():
		child.queue_free()
	var i = 1
	while  i <= GeneralRules.LEVELS:
		var level_btn = LevelBtn.instantiate()
		level_btn.level = i
		levels_container.add_child(level_btn)
		i += 1
