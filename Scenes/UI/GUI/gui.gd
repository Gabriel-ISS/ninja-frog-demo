extends CanvasLayer

class_name Gui

@export var music: AudioStream
@export var fruits_node: Node

@export_category('Private')
@export var _points_label: PointsCounter
@export var _hp: HealthPoints
@export var _music_player: AudioStreamPlayer
@export var _menu: Control
@export var _controls: Control
@export var _end_level_menu: EndLevelMenu
@export var _cronometer: Cronometer

var available_points = 0

func _ready() -> void:
	visible = true
	
	# music
	_music_player.stream = music
	_music_player.play()
	
	# pause _menu
	_menu.visible =  false
	get_tree().paused = false
	
	# time
	_cronometer.start()
	
	# update total points
	if fruits_node.is_node_ready():
		_update_available_points()
	else:
		fruits_node.connect(
			'ready', func(): _update_available_points()
		)


func _update_available_points():
	for fruit: Fruit in fruits_node.get_children():
		available_points += GeneralRules.POINTS[fruit.fruit_type]


func set_points(points: int):
	_points_label.current = points


func add_life():
	_hp.add_life()


func remove_life():
	_hp.remove_life()


func open_end_level_menu():
	get_tree().paused = true
	
	var time = _cronometer.stop()
	var level = GeneralRules.current_level
	var record = LocalStorage.get_record(level)
	var points = _points_label.current
	
	# points
	_end_level_menu.set_points(points, available_points)
	
	# time
	_end_level_menu.set_time(time)
	
	# record time
	if not record or time < record:
		_end_level_menu.set_record_time(time)
		LocalStorage.set_record(level, time)
	else:
		_end_level_menu.set_record_time(record)

	_end_level_menu.visible = true


func _on_music_player_finished() -> void:
	_music_player.play()


func _on_pause_pressed() -> void:
	_cronometer.stop()
	get_tree().paused = true
	_controls.visible = false
	_menu.visible = true
