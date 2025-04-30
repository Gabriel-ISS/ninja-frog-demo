extends CanvasLayer

class_name Gui

@export var music: AudioStream

@onready var music_player = $MusicPlayer
@onready var menu = $PauseMenu
@onready var end_level_menu = $EndLevelMenu
@onready var hp: HealthPoints = $HP 
@onready var points_label: PointsCounter = $HBoxContainer/Points/PointsCounter

func _ready() -> void:
	visible = true
	
	# music
	music_player.stream = music
	music_player.play()
	
	# pause menu
	menu.visible =  false
	get_tree().paused = false


func open_end_level_menu():
	var level = GeneralRules.current_level
	var record = LocalStorage.get_record(level)
	var points = points_label.current
	
	get_tree().paused = true
	end_level_menu.total_points = points
	end_level_menu.visible = true
	
	if not record or points > record:
		end_level_menu.record = points
		LocalStorage.set_record(level, points)
	else:
		end_level_menu.record = record


func _on_music_player_finished() -> void:
	music_player.play()


func _on_pause_pressed() -> void:
	get_tree().paused = true
	menu.visible = true
