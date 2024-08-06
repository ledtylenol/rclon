extends Resource
class_name ProjData

@export var sprite: AtlasTexture

@export_group("Projectile Stats")
@export var effects: int = 0
@export var min_dmg: int
@export var max_dmg: int
@export var range: float = 2.0
@export var lifetime: float = 1.0
var speed := range / lifetime
