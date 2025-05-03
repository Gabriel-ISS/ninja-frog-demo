extends TextureRect

# necesario psolo en la pantalla de inicio
@export var backgrounds: Array[Texture]

func _ready() -> void:
	if not GeneralRules.current_bg:
		var i = get_random_index()
		GeneralRules.current_bg = backgrounds[i]
	
	texture = GeneralRules.current_bg


func get_random_index():
	if backgrounds.is_empty():
		printerr('Backgrounds not found')
		return 0
	var last_selected = LocalStorage.last_bg
	var last_i = backgrounds.size() - 1
	var r = randi_range(0, last_i)
	
	if r != last_selected: return r
	
	if r == 0: return r + 1
	if r == last_i: return r - 1
