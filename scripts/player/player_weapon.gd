extends Equipment
class_name PlayerWeapon

@export_group("Weapon Params")
@export var projectile: ProjData
@export var bullet_pattern: PackedScene
@export var rof_mult: float = 1.0
