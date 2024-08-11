extends Area2D
class_name Hitbox

var effects: Array[StatusEffect]
var is_enemy := false
var pierce := false
var ignored_hb: Array[Hurtbox] = []
var damage := 0
func _init(_damage: int, _is_enemy: bool, _effects: Array[StatusEffect] = [], _pierce = false) -> void:
	self.damage = _damage
	self.is_enemy = _is_enemy
	self.effects = _effects
	self.pierce = _pierce
func _ready() -> void:
	collision_mask = 0
	if is_enemy:
		collision_layer = 1 << Constants.PLAYER_LAYER
	else:
		collision_layer = 1 << Constants.ENEMY_LAYER
