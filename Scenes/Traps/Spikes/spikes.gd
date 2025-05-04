@tool
extends Node2D


@export_range(1, 10) var spikes_pairs = 3:
	set(value):
		spikes_pairs = value
		create_spikes(value)

@export_category("Private")
@export var _SpikePair: PackedScene


func  _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS if visible else PROCESS_MODE_DISABLED
	
	create_spikes(spikes_pairs)


func create_spikes(quantity):
	for pair: Sprite2D in get_children():
		pair.free()
		
	var count = 0
	while count < quantity:
		var spike_pair: Sprite2D = _SpikePair.instantiate()
		spike_pair.position.x = (
			count * 
			spike_pair.texture.get_size().x * 
			spike_pair.scale.x
		)
		add_child(spike_pair)
		count += 1
