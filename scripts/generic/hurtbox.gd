extends Area2D
class_name Hurtbox

signal hit(who: Hitbox, how_much: int, effects: int)

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	var hitbox := area as Hitbox
	if not hitbox:
		return
	if hitbox.ignored_hb.has(self):
		return
	hitbox.ignored_hb.push_back(self)
	hit.emit(hitbox, hitbox.damage, hitbox.effects)
