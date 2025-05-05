extends Node

class_name State

const DEFAULT_GARVITY = 980.0
const DEFAULT_SPEED = 300
const DEFAULT_JUMP_VELOCITY = -400
const DEFAULT_DELTA_MOVE_TOWARD = 20

var GARVITY = DEFAULT_GARVITY
var SPEED = DEFAULT_SPEED
var JUMP_VELOCITY = DEFAULT_JUMP_VELOCITY 
var DELTA_MOVE_TOWARD = DEFAULT_DELTA_MOVE_TOWARD

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
