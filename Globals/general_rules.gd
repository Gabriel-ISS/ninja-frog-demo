extends Node

const DEBUG_PLAYER = false

const LEVELS = 4
var DEADLY_Y_POSITION = 1000
const POINTS = {
	'apple': 1,
	'banana': 2,
	'cherry': 3,
	'kiwy': 4,
	'melon': 5,
	'orange': 6,
	'pineapple': 7,
	'strawberry': 8
}

const LIFES_PER_DIFICULT_LEVEL = [5, 3, 1]

var initial_lifes = LIFES_PER_DIFICULT_LEVEL[LocalStorage.dificult_level]
var current_level = 0

func _ready() -> void:
	DEADLY_Y_POSITION = get_viewport().size.x + 100
