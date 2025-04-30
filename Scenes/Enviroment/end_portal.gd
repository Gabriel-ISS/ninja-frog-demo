extends Node2D

var gui: Gui

func _ready() -> void:
	gui = get_parent().get_node('Gui')
	if not gui:
		printerr("'Gui' not found")


func open_end_level_menu():
	var current = GeneralRules.current_level
	var last = LocalStorage.last_completed_level
	if current > last:
		LocalStorage.last_completed_level = current
	gui.open_end_level_menu()


func _on_player_detect_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	call_deferred("open_end_level_menu")
