extends CanvasLayer

class_name Gui

@export var music: AudioStream

@onready var music_player = $MusicPlayer
@onready var menu = $PauseMenu
@onready var end_level_menu = $EndLevelMenu
@onready var hp: HealthPoints = $HP 
@onready var points: PointsCounter = $HBoxContainer/Points/PointsCounter

func _ready() -> void:
	visible = true
	
	# music
	music_player.stream = music
	music_player.play()
	
	# pause menu
	menu.visible =  false
	get_tree().paused = false


func open_end_level_menu():
	get_tree().paused = true
	end_level_menu.total_points = points.current
	end_level_menu.visible = true


func _on_music_player_finished() -> void:
	music_player.play()


func _on_pause_pressed() -> void:
	get_tree().paused = true
	menu.visible = true
