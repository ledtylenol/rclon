extends Node2D
class_name VelocityComponent

var velocity := Vector2.ZERO
var former_velocity := Vector2.ZERO
var delta: float

@export_category("Velocity Parameters")
@export var max_velocity := 500.0:
	set(value):
		max_velocity = value
@export var acceleration := 10.0
@export var friction := 30.0
@export var stop_speed := 5.0

signal mod_changed

func _physics_process(delta: float) -> void:
	self.delta = delta

func accel_to_dir(dir: Vector2):
	velocity = Math.smooth_nudgev(velocity, dir * max_velocity, acceleration, delta)

func accel_to_vel(vel: Vector2):
	velocity = Math.smooth_nudgev(velocity, vel, acceleration, delta)

func decelerate():
	velocity = Math.smooth_nudgev(velocity, Vector2.ZERO, friction, delta)

func snap_to_dir(dir: Vector2) -> void:
	velocity = dir * max_velocity


func rotate_to(dir: float):
	velocity = velocity.rotated(dir)

func move(dir: Vector2) -> void:
	var speed: float
	speed = max_velocity
	var new_vel := velocity
	var dot := new_vel.dot(dir)
	var add_speed: float
	add_speed = speed - dot
	if add_speed <= 0:
		return
	var accel: float
	accel = maxf(1.0, acceleration) * speed * delta
	if add_speed > add_speed:
		accel = add_speed
	
	velocity +=  accel * dir

func apply_friction(dir: Vector2) -> void:
	var new_vel := velocity
	if is_equal_approx(velocity.normalized().dot(dir), 1.0):
		return
	var speed := new_vel.length()
	if speed < 0.001:
		return
	var control: float
	if speed < stop_speed:
		control = stop_speed
	else:
		control = speed
	var new_speed := speed - delta * control * friction
	if new_speed <= 0.0:
		new_speed = 0.0
	new_speed /= speed
	velocity = new_vel * new_speed
