extends CanvasLayer

const LevelBtn = preload("res://Scenes/UI/SelectLevelScreen/level_btn.tscn")

@onready var levels_grid = $VBoxContainer/MarginContainer/HFlowContainer

func _ready() -> void:
	for child in levels_grid.get_children():
		child.queue_free()
	var i = 1
	while  i <= GeneralRules.LEVELS:
		var level_btn = LevelBtn.instantiate()
		level_btn.level = i
		levels_grid.add_child(level_btn)
		i += 1
