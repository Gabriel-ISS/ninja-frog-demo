extends Node

class_name State

const DEFAULT_GARVITY = 980.0
const DEFAULT_SPEED = 300
const DEFAULT_JUMP_VELOCITY = -400
const DEFAULT_DELTA_MOVE_TOWARD = 30
const AIR_DELTA_MOVE_TOWARD = 7

var invencivility = false
var gravity = DEFAULT_GARVITY
var speed = DEFAULT_SPEED
var jump_speed = DEFAULT_JUMP_VELOCITY 
var delta_move_toward = DEFAULT_DELTA_MOVE_TOWARD

var character: Character
var sprite: AnimatedSprite2D
var next_state: State = null
var wait_end = false

func process_state(_delta: float):
	pass

func on_enter():
	pass

func on_exit():
	pass

func on_input(_event: InputEvent):
	pass

func on_sprite_animation_finished(_animation_name):
	pass
