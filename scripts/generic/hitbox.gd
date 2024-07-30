extends Area2D
class_name Hitbox

var effects := 0
var is_enemy := false
var pierce := false
var ignored_hb: Array[Hurtbox] = []
var damage := 0
func _init(damage: int, is_enemy: bool, effects: int = 0, pierce = false) -> void:
	self.damage = damage
	self.is_enemy = is_enemy
	self.effects = effects
	self.pierce = pierce
func _ready() -> void:
	collision_layer = 0
	if is_enemy:
		collision_mask = 1 << Constants.PLAYER_LAYER
	else:
		collision_mask = 1 << Constants.ENEMY_LAYER
