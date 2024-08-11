# // state_machine.gd
class_name StateMachine

signal enter(state_name: StringName)
signal exit(state_name: StringName)

var current_state: State
var blackboard := {}
var states: Dictionary

static func create(initial_states: Dictionary) -> StateMachine:
	var state_machine := {}
	for state in initial_states:
		var transitions = initial_states[state]
		var state_obj = State.new(state)
		if transitions.has("enter"):
			state.enter = transitions["enter"]
			transitions.erase("enter")
		if transitions.has("exit"):
			state.exit = transitions["exit"]
			transitions.erase("exit")
		state_obj.transitions = transitions
		state_machine[state] = state_obj
	for state_name in state_machine:
		var state = state_machine[state_name]
		for transition_name in state.transitions:
			var destination_state_name = state.transitions[transition_name]
			state.transitions[transition_name] = state_machine[destination_state_name]
	var result := StateMachine.new()
	result.state_machine = state_machine
	return result

func set_current_state(state_name: StringName) -> StateMachine:
	if not states.has(state_name):
		return self
	current_state = states[state_name]
	current_state.enter.call(blackboard)
	enter.emit(current_state.name)
	return self


func transition_to(transition_name: String):
	var new_state = current_state.get_transition(transition_name)
	if new_state != null:
		current_state.exit.call(blackboard)
		exit.emit(current_state.name)
		set_current_state(new_state.name)
