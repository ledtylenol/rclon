extends Projectile
class_name SinProjectile

@export var t := 1.0
@export var amplitude := 10.0
@export var f0 := 0.0

var time := 0.0
func _physics_process(delta: float) -> void:
	time += delta
	move(delta)
func move(delta: float) -> void:
	velocity = global_transform.y * sin(f0 + time * 2 * PI * t) * amplitude
	child_sprite.rotation = (rotation + sin(f0 + time * 2 * PI * t)) / 2.0
	super.move(delta)
