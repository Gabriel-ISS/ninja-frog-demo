extends GridContainer

class_name HealthPoints

const Heart: PackedScene = preload("res://Scenes/UI/GUI/heart.tscn")

func _ready() -> void:
	for child in get_children():
		child.queue_free()
	var hp = 0
	while hp < GeneralRules.initial_lifes:
		hp += 1
		addLife()

func addLife():
	var heart = Heart.instantiate()
	add_child(heart)

func removeLife():
	var element = get_child(0)
	if not element: return
	element.queue_free()
