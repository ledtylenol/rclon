extends Node
class_name HealthComponent

var current_health := max_health: set = set_health
@export var max_health := 100
@export var hurtbox: Hurtbox

signal health_changed(how_much: int)
signal dead()
func _ready() -> void:
	if hurtbox:
		hurtbox.hit.connect(on_hit)


func on_hit(who: Hitbox, how_much: int, effects: Array[StatusEffect]):
	current_health -= how_much

func set_health(value: int) -> void:
	current_health = value
	health_changed.emit(value)
	if value <= 0:
		dead.emit()
