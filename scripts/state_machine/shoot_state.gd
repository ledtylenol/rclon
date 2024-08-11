extends PlayerState
class_name ShootState

var cooldown := 0.0
const T_1_DAGGERS = preload("res://assets/equipments/weapons/t1daggers.tres")
const T_1_STAFF = preload("res://assets/equipments/weapons/t1staff.tres")
func on_enter() -> void:
	player.former_direction = (player.get_global_mouse_position() - player.global_position).normalized()
	var sig = player.get_local_mouse_position().normalized().dot(sprite.transform.x)
	sprite.flip_h = sig < 0.0
	if cooldown:
		if player.direction:
			transitioned.emit(self, "walk")
			return
		else:
			transitioned.emit(self, "idle")
			return
	sprite.stop()
	sprite.animation_finished.connect(shoot)

	shoot()
func _process(delta: float) -> void:
	cooldown = maxf(minf(cooldown - delta, 1.0 / (player.attacks_per_sec * (player.weapon.rof_mult))), 0.0)
	sprite.speed_scale = player.attacks_per_sec * (player.weapon.rof_mult)
	var sig = player.get_local_mouse_position().normalized().dot(sprite.transform.x)
	var o_sign = player.get_local_mouse_position().normalized().dot(sprite.transform.y)

	player.former_direction = (player.get_global_mouse_position() - player.global_position).normalized()
	if not sprite.is_playing():
		if sig <= 0.79 and sig >= -0.77:
			if o_sign <= -0.60:
				sprite.play("shoot_up")
			elif o_sign >= 0.60:
				sprite.play("shoot_down")
		elif (sig >= 0.76 or sig <= -0.77) and o_sign >= -0.66 and o_sign <= 0.66:
				sprite.play("shoot_right")
	sprite.flip_h = sig < 0.0 and not (sprite.animation == "shoot_down" or sprite.animation == "shoot_up")
	if Input.is_action_just_pressed("dash"):
		if player.weapon == T_1_DAGGERS:
			player.weapon = T_1_STAFF
		else:
			player.weapon = T_1_DAGGERS
	if not Input.is_action_pressed("shoot"):
		if player.direction:
			transitioned.emit(self, "walk")
			return
		else:
			transitioned.emit(self, "idle")
			return
func on_exit() -> void:
	sprite.speed_scale = 1.0
	if sprite.animation_finished.is_connected(shoot):
		sprite.animation_finished.disconnect(shoot)
func shoot() -> void:
	var weapon := player.weapon
	var shoot_dir := (player.get_global_mouse_position() - player.global_position).normalized()

	var data = player.weapon.projectile.duplicate(true)
	var GROUP = player.weapon.bullet_pattern
	var proj = GROUP.instantiate()
	proj.is_enemy = false
	proj.proj_data = data
	proj.rotate(shoot_dir.angle())
	proj.global_position = player.global_position
	get_tree().root.add_child(proj)
	cooldown = 1.0 / (player.attacks_per_sec * player.weapon.rof_mult)
