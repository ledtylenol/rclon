extends CharacterBody2D
class_name Projectile


var projectile_data: ProjData
var speed := 0.0
var is_enemy := false
func _init(data: ProjData, is_enemy: bool) -> void:
	projectile_data = data.duplicate(true)
	self.is_enemy = is_enemy
func _ready() -> void:
	var damage = randi_range(projectile_data.min_dmg, projectile_data.max_dmg)
	var hitbox := Hitbox.new(damage, is_enemy, projectile_data.effects)
	add_child(hitbox)
	var collider := CollisionShape2D.new()
	collider.shape = CircleShape2D.new()
	collider.shape.radius = 5.0
	hitbox.add_child(collider)
	var sprite := Sprite2D.new()
	sprite.texture = projectile_data.sprite
	add_child(sprite)
	add_child(collider.duplicate())
	speed = projectile_data.range * Constants.TILE_SIZE / projectile_data.lifetime
	print(speed)
	collision_mask = 1
	collision_layer = 0
	print(projectile_data.lifetime)
func _physics_process(delta: float) -> void:
	projectile_data.lifetime -= delta
	if projectile_data.lifetime <= 0.0:
		queue_free()
	move(delta)
func move(dt: float) -> void:
	velocity = transform.x * speed
	var c = move_and_collide(velocity * dt)
	if c != null:
		queue_free()
