extends Node
class_name StateMachine


@export var initial_state: State
var states: Dictionary
var current_state: State
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_state_transition)
			child.process_mode = Node.PROCESS_MODE_DISABLED
	initial_state.process_mode = Node.PROCESS_MODE_INHERIT
	current_state = initial_state

func on_state_transition(state: State, next: String) -> void:
	var next_state: State = states[next.to_lower()]
	if not next_state:
		return
	if next_state == current_state:
		return
	current_state.on_exit()
	current_state.process_mode = Node.PROCESS_MODE_DISABLED
	next_state.on_enter()
	next_state.process_mode = Node.PROCESS_MODE_INHERIT
	current_state = next_state
