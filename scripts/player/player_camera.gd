extends Camera2D
class_name PlayerCamera

@onready var sprite: AnimatedSprite2D = $"../AnimatedSprite2D"

@export var target_node: Node2D 
@export var velocity_component: VelocityComponent
var target := Vector2.ZERO
var follow_speed := 5.0
var target_offset := false
var snap := true
var target_zoom := 5.49
var zoom_speed := 5.0
func _physics_process(delta: float) -> void:
	var rot := Input.get_axis("rotate_l", "rotate_r")
	update_target()
	var target = target if not target_offset else target - transform.y * 35.0
	if snap:
		position = target
		zoom = Vector2(target_zoom, target_zoom)
	else:
		global_position = Math.smooth_nudgev(global_position, target, follow_speed, delta)
		zoom = Math.smooth_nudgev(zoom, Vector2(target_zoom, target_zoom), zoom_speed, delta)
	if Input.is_key_label_pressed(KEY_Z):
		sprite.rotation = 0
	sprite.rotate(PI/2 * rot * delta * 2.0)
	rotation = sprite.rotation


func update_target() -> void:
	if target_node:
		target = target_node.global_position

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_X:
				target_offset = not target_offset
			KEY_C:
				snap = not snap
			KEY_EQUAL:
				target_zoom = clampf(target_zoom * 1.15, 1.0, 10.0)
			KEY_MINUS:
				target_zoom = clampf(target_zoom * 0.85, 1.0, 10.0)
