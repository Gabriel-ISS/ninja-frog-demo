extends Label

@export var state_machine: StateMachine

func _ready() -> void:
	if not GeneralRules.DEBUG_PLAYER:
		visible = false
		process_mode = PROCESS_MODE_DISABLED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	self.text = state_machine.current_state.name
