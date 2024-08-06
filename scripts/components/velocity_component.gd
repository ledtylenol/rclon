extends Node
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

signal mod_changed
func _ready() -> void:
	var p = get_parent() as Entity
	if p:
		p.velocity_component = self

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
