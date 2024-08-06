extends Node
class_name HealthComponent

var current_health := max_health
@export var max_health := 100
@export var hurtbox: Hurtbox

func _ready() -> void:
	if hurtbox:
		hurtbox.hit.connect(on_hit)


func on_hit(who: Hitbox, how_much: int, effects: Array[StatusEffect])
