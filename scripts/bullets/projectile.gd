extends CharacterBody2D
class_name Projectile


@export var projectile_data: ProjData
var speed := 0.0
var is_enemy := false
var child_sprite: Sprite2D
func _ready() -> void:
	await get_tree().physics_frame
	var damage = randi_range(projectile_data.min_dmg, projectile_data.max_dmg)
	var hitbox := Hitbox.new(damage, is_enemy, projectile_data.effects)
	add_child(hitbox)
	var collider := CollisionShape2D.new()
	collider.shape = CircleShape2D.new()
	collider.shape.radius = 5.0
	hitbox.add_child(collider)
	child_sprite = Sprite2D.new()
	child_sprite.texture = projectile_data.sprite
	add_child(child_sprite)
	add_child(collider.duplicate())
	speed = projectile_data.range * Constants.TILE_SIZE / projectile_data.lifetime
	collision_mask = 1
	collision_layer = 0

func move(dt: float) -> void:
	var c = move_and_collide(velocity * dt)
	if c != null:
		queue_free()
