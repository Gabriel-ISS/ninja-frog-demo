extends Node2D

class_name Portal

@export var objetive_portal: Portal
@onready var timer = $Timeout
@onready var teleport_sound = $Teleport


func _on_player_detect_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if not timer.is_stopped(): return
	timer.start()
	objetive_portal.timer.start()
	
	var player = area.get_parent()
	if player is Character: 
		player.velocity = Vector2(0, 0)
		player.position = objetive_portal.position
		teleport_sound.play()
