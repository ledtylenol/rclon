extends Node
class_name Equipments
@export var equipment_array: Array[Equipment]
var weapon_dict: Dictionary
var ability_dict: Dictionary
var armor_dict: Dictionary
var ring_dict: Dictionary
func _ready() -> void:
	for equipment: Equipment in equipment_array:
		var name := equipment.name.to_lower()
		if equipment is PlayerWeapon:
			weapon_dict[name] = equipment
		if equipment is PlayerAbility:
			ability_dict[name] = equipment
		if equipment is PlayerArmor:
			armor_dict[name] = equipment
		if equipment is PlayerRing:
			ring_dict[name] = equipment
