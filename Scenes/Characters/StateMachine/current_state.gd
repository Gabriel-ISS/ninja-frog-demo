extends Label

# para debbug del state machine
@export var _state_machine: StateMachine

func _ready() -> void:
	if not GeneralRules.DEBUG_PLAYER:
		visible = false
		process_mode = PROCESS_MODE_DISABLED

func _process(_delta: float) -> void:
	self.text = _state_machine.current_state.name
