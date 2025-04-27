extends StaticBody2D

@export var off_time: float = 1.0
@export var on_time: float = 1.0

@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite
@onready var damage_zone = $DamageZone/CollisionShape2D

var is_on = false

func _ready() -> void:
	on()


func on():
	is_on = true
	timer.wait_time = on_time
	damage_zone.disabled = false
	animated_sprite.play("on")
	timer.start()


func off():
	is_on = false
	timer.wait_time = off_time
	damage_zone.disabled = true
	animated_sprite.play("off")
	timer.start()


func _on_timer_timeout() -> void:
	if is_on:
		off()
	else:
		on()
