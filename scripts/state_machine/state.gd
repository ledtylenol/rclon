# // state.gd
class_name State

var name: StringName
var transitions := {}
var enter := func(data: Dictionary): pass
var exit := func(data: Dictionary): pass


func _init(init_name):
	name = init_name


func get_transition(name: StringName) -> State:
	if transitions.has(name):
		return transitions[name] as State
	else:
		return null
