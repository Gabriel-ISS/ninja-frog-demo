extends ParallaxBackground

@export var SPRITE_WIDTH = 1920

func _ready() -> void:
	pass
	update_bg_size()
	get_viewport().connect("size_changed", func (): update_bg_size())

func update_bg_size():
	var window_width = get_viewport().size.x
	for child: ParallaxLayer in get_children():
		# set mirror
		child.motion_mirroring.x = get_viewport().size.x
		
		# set prite scale to fit screen
		var sprite: Sprite2D = child.get_children()[0]
		var sprite_width = sprite.texture.get_width()
		var new_sprite_scale = float(window_width) / float(sprite_width)
		sprite.scale = Vector2(new_sprite_scale, new_sprite_scale)
