extends Equipment
class_name PlayerWeapon

@export_group("Weapon Params")
@export var projectile: ProjData

@export var rof_mult: float
@export var shot_count: int = 1
@export var spread: float
