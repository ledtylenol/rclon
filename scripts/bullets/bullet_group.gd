extends Node2D
class_name BulletGroup

@export var lifetime := 1.0
@export var range := 5.0
var velocity := Vector2.ZERO
var proj_data : ProjData
var is_enemy := false
var speed := 0.0
func _ready() -> void:
	for child: Projectile in get_children().filter(func(child): return child is Projectile):
		child.projectile_data = proj_data.duplicate(true)
		child.is_enemy = is_enemy
	if proj_data:
		print("PROJ")
		lifetime = proj_data.lifetime
		range = proj_data.range
	speed = Constants.TILE_SIZE * range / lifetime

func _physics_process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()
	velocity = transform.x * speed * delta
	global_position += velocity
