extends Node
class_name EffectComponent


var effects: Array[StatusEffect]

@export var hurtbox: Hurtbox
@export var parent: Entity
var ticking_effects := true

signal add_effect(which: int)
signal remove_effect(which: int)
func _ready() -> void:
	if hurtbox:
		hurtbox.hit.connect(on_hit)
	if get_parent() is Entity:
		parent = get_parent()
	else:
		queue_free()

func _process(delta: float) -> void:
	if ticking_effects:
		for effect in effects:
			effect.tick(delta)
func on_hit(_who: Hitbox, _m: int, _effects: Array[StatusEffect]) -> void:
	for effect in _effects:
		do_effect(effect)


func push_effect(effect: StatusEffect) -> void:
	print('effect pushed')
	var e := effect.get_effect()
	add_effect.emit(e)
	effects.push_back(effect)
	effect.queue_remove.connect(pop_effect)

func pop_effect(which: StatusEffect, idx: int) -> void:
	print("aaaa")
	remove_effect.emit(idx)
	effects.erase(which)
	print(which)

func do_effect(effect: StatusEffect) -> void:
	var effect_idx = self.effects.filter(func(x): return x.effect == effect.effect)
	if not effect_idx.is_empty():
		var e = effect_idx[0]
		e.duration = maxf(e.duration, effect.duration)
	else:
		print(effect is StatusEffect)
		push_effect(effect as StatusEffect)
