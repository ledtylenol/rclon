extends PlayerState
class_name WalkState
var prev_dir := Vector2.ZERO

func on_enter() -> void:
	var sig = player.direction.dot(sprite.transform.x)
	var o_sign = player.direction.dot(sprite.transform.y)
	if sig <= 0.72 and sig >= -0.72:
		if o_sign <= -0.70:
			sprite.play("move_up")
		elif o_sign >= 0.70:
			sprite.play("move_down")
	elif (sig >= 0.70 or sig <= -0.72) and o_sign >= -0.70 and o_sign <= 0.72:
		
		sprite.play("move_right")
		sprite.flip_h = sig <= 0.0 and sprite.animation == "move_right" 


func _process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		transitioned.emit(self, "shoot")
		return
	var sig = player.direction.dot(sprite.transform.x)
	var o_sign = player.direction.dot(sprite.transform.y)
	if not player.direction:
		transitioned.emit(self, "idle")
		return
	if not sprite.is_playing() or prev_dir != player.direction:
		if sig <= 0.72 and sig >= -0.72:
			if o_sign <= -0.70:
				sprite.play("move_up")
			elif o_sign >= 0.70:
				sprite.play("move_down")
		elif (sig >= 0.70 or sig <= -0.72) and o_sign >= -0.70 and o_sign <= 0.72:
			
			sprite.play("move_right")
			sprite.flip_h = sig <= 0.0 and sprite.animation == "move_right" 


	prev_dir = player.direction
