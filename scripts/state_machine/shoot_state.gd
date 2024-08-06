extends PlayerState
class_name ShootState

var cooldown := 0.0
func on_enter() -> void:
	sprite.stop()
func _process(delta: float) -> void:
	cooldown = maxf(cooldown - delta, 0.0)
	if not cooldown:
		cooldown = 1.0 / (player.attacks_per_sec * (1.0 + player.weapon.rof_mult))
		shoot()
	sprite.speed_scale = player.attacks_per_sec * (1.0 + player.weapon.rof_mult)
	var sign = player.get_local_mouse_position().normalized().dot(sprite.transform.x)
	var o_sign = player.get_local_mouse_position().normalized().dot(sprite.transform.y)

	player.former_direction = (player.get_global_mouse_position() - player.global_position).normalized()
	if not sprite.is_playing():
		if sign <= 0.79 and sign >= -0.77:
			if o_sign <= -0.60:
				sprite.play("shoot_up")
			elif o_sign >= 0.60:
				sprite.play("shoot_down")
		elif (sign >= 0.76 or sign <= -0.77) and o_sign >= -0.66 and o_sign <= 0.66:
				sprite.play("shoot_right")
	sprite.flip_h = sign < 0.0 and sprite.animation == "shoot_right"

	if not Input.is_action_pressed("shoot"):
		if player.direction:
			transitioned.emit(self, "walk")
			return
		else:
			transitioned.emit(self, "idle")
			return
func on_exit() -> void:
	sprite.speed_scale = 1.0

func shoot() -> void:
	var weapon := player.weapon
	var shoot_dir := (player.get_global_mouse_position() - player.global_position).normalized()
	if weapon.spread:
		var p := weapon.shot_count / 2
		for i in range(-p, p + weapon.shot_count % 2):
			var data = player.weapon.projectile.duplicate(true)
			var proj = Projectile.new(data, false)
			if weapon.shot_count % 2:
				
				proj.rotate(shoot_dir.angle() + weapon.spread * i)
			else:
				proj.rotate(shoot_dir.angle() + weapon.spread * i + weapon.spread / weapon.shot_count)
			proj.global_position = player.global_position

			get_tree().root.add_child(proj)
	else:
		for i in range(weapon.shot_count):
			var data = player.weapon.projectile.duplicate(true)
			var proj = Projectile.new(data, false)

			proj.rotate(shoot_dir.angle())
			proj.global_position = player.global_position
			get_tree().root.add_child(proj)
			await get_tree().create_timer(1.0 / (weapon.shot_count * player.attacks_per_sec * (1.0 + player.weapon.rof_mult))).timeout
