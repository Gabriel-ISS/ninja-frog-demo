extends HSlider

@export_enum('music', 'effects')
var bus: String

var key: String
var bus_index = {
	'music': 1,
	'effects': 2
}

func _ready() -> void:
	key = bus + '_volume'
	value = LocalStorage[key]
	AudioServer.set_bus_volume_db(bus_index[bus], value - 100)


func _value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index[bus], new_value - 100)
	AudioServer.set_bus_mute(bus_index[bus], new_value == min_value)
	LocalStorage[key] = new_value
