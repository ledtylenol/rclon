extends CharacterBody2D
class_name Entity

var effects := 0: set = set_effects
var is_dead := false
var ticking_effects := false
@export var velocity_component: VelocityComponent

func set_effects(which: int) -> void:
	effects = which
