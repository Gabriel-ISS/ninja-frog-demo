extends CanvasLayer

class_name Gui

@export var music: AudioStream

@onready var music_player = $MusicPlayer
@onready var menu = $PauseMenu
@onready var end_level_menu: EndLevelMenu = $EndLevelMenu
@onready var hp: HealthPoints = $HP 
@onready var points_label: PointsCounter = $HBoxContainer/Points/PointsCounter

var total_points = 0

func _ready() -> void:
	visible = true
	
	# music
	music_player.stream = music
	music_player.play()
	
	# pause menu
	menu.visible =  false
	get_tree().paused = false
	
	# update total points
	var fruits_node = get_parent().get_node('Fruits')
	if fruits_node.is_node_ready():
		update_total_points(fruits_node)
	else:
		fruits_node.connect(
			'ready', func(): update_total_points(fruits_node)
		)


func update_total_points(fruits_node: Node):
	for fruit: Fruit in fruits_node.get_children():
		total_points += GeneralRules.POINTS[fruit.fruit_type]


func open_end_level_menu():
	var level = GeneralRules.current_level
	var record = LocalStorage.get_record(level)
	var points = points_label.current
	
	get_tree().paused = true
	end_level_menu.set_points(points, total_points)
	end_level_menu.visible = true
	
	if not record or points > record:
		end_level_menu.set_record(points)
		LocalStorage.set_record(level, points)
	else:
		end_level_menu.set_record(record)


func _on_music_player_finished() -> void:
	music_player.play()


func _on_pause_pressed() -> void:
	get_tree().paused = true
	menu.visible = true
