extends PlayerState
class_name WalkState
var prev_dir := Vector2.ZERO

func on_enter() -> void:
	var sign = player.direction.dot(sprite.transform.x)
	var o_sign = player.direction.dot(sprite.transform.y)
	if sign <= 0.72 and sign >= -0.72:
		if o_sign <= -0.70:
			sprite.play("move_up")
		elif o_sign >= 0.70:
			sprite.play("move_down")
	elif (sign >= 0.70 or sign <= -0.72) and o_sign >= -0.70 and o_sign <= 0.72:
		
		sprite.play("move_right")
		sprite.flip_h = sign <= 0.0 and sprite.animation == "move_right" 


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		transitioned.emit(self, "shoot")
		return
	var sign = player.direction.dot(sprite.transform.x)
	var o_sign = player.direction.dot(sprite.transform.y)
	if not player.direction:
		transitioned.emit(self, "idle")
		return
	if not sprite.is_playing() or prev_dir != player.direction:
		if sign <= 0.72 and sign >= -0.72:
			if o_sign <= -0.70:
				sprite.play("move_up")
			elif o_sign >= 0.70:
				sprite.play("move_down")
		elif (sign >= 0.70 or sign <= -0.72) and o_sign >= -0.70 and o_sign <= 0.72:
			
			sprite.play("move_right")
			sprite.flip_h = sign <= 0.0 and sprite.animation == "move_right" 


	prev_dir = player.direction
