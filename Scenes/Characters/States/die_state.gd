extends State

@export var ground_state: State
@export var die_audio: AudioStreamPlayer
@export var restart_timer: Timer

func on_enter():
	wait_end = true
	character.lock_direction = true
	character.lock_movement = true
	sprite.play("disappair")
	die_audio.play()

func on_sprite_animation_finished(_animation_name):
	sprite.queue_free()

func _on_death_finished() -> void:
	get_tree().reload_current_scene()
