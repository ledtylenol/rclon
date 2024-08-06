extends PlayerState
class_name IdleState

var animations = {
	0: "idle_right",
	1: "idle_up",
	2: "idle_right",
	3: "idle_down",
}
func on_enter() -> void:
	var angle = sprite.transform.x.angle_to(player.former_direction)

	if angle >= -3*PI/4 and angle <= -PI/4:
		sprite.play("idle_up")
	elif angle <= PI/4 or abs(angle) > 0.01 + 3*PI/4:
		sprite.play("idle_right")
	else:
		sprite.play("idle_down")
func _process(delta: float) -> void:
	if animations.find_key(sprite.animation as String) != null:
		var i: int = animations.find_key(sprite.animation as String)

		var angle := sprite.transform.x.angle_to(player.former_direction)
		if angle >= -3*PI/4 and angle <= -PI/4:
			sprite.play("idle_up")
		elif angle <= PI/4 or abs(angle) > 0.01 + 3*PI/4:
			sprite.play("idle_right")
		else:
			sprite.play("idle_down")
		sprite.flip_h = abs(angle) > PI/2 and sprite.animation == "idle_right"
	if Input.is_action_pressed("shoot"):
		transitioned.emit(self, "shoot")
		return
	elif player.direction:
		transitioned.emit(self, "walk")
		return
