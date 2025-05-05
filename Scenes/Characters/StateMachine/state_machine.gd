extends Node

class_name StateMachine

const DEBBUG = GeneralRules.DEBUG_PLAYER

@export var character: Character
@export var sprite: AnimatedSprite2D
@export var invencivility_timer: Timer

@export var current_state: State
@export var damage_state: State

var states: Array[State] = []

func _ready() -> void:
	for child in self.get_children():
		if child is State:
			child.character = character
			child.sprite = sprite
			states.append(child)
	current_state.on_enter()

func _physics_process(_delta: float) -> void:
	current_state.process_state(_delta)
	if current_state.next_state != null:
		change_state(current_state.next_state)

func change_state(new_state: State):
	if current_state.wait_end: return
	current_state.on_exit()
	current_state.next_state = null
	current_state = new_state
	if DEBBUG:
		print_debug(current_state.name)
	current_state.on_enter()

func _input(event: InputEvent) -> void:
	current_state.on_input(event)

func _on_animations_animation_finished() -> void:
	current_state.on_sprite_animation_finished(sprite.animation)

func _on_damage_detection_area_shape_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if current_state.invencivility: return
	change_state(damage_state)
