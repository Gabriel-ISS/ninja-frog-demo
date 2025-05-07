extends Label


enum TARGET {
	ALL,
	TOUCHSCREEN_AVAILABLE,
	TOUCHSCREEN_UNAVAILABLE
}
@export var target: TARGET = TARGET.ALL

func _ready() -> void:
	var has_touchscreen = DisplayServer.is_touchscreen_available()
	
	if target == TARGET.TOUCHSCREEN_AVAILABLE:
		visible = has_touchscreen
	elif target == TARGET.TOUCHSCREEN_UNAVAILABLE:
		visible = !has_touchscreen
