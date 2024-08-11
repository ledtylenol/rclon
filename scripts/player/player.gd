extends Entity
class_name Player

#stats
@export var stats: PlayerStats

@export var weapon: PlayerWeapon
@export var ability: PlayerAbility
@export var armor: PlayerArmor
@export var ring: PlayerRing
@onready var player_camera: PlayerCamera = $PlayerCamera
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


var direction := Vector2.ZERO
var former_direction := Vector2.ZERO
var former_velocity := Vector2.ZERO
var attacks_per_sec := 1.0:
	set(value):
		attacks_per_sec = clampf(value, 0.2, 50.0)
var hps := 0.0
var mps := 0.0

var current_hp:= 100.0
func _ready() -> void:
	recalculate_aps()
	recalculate_tps()
	recalculate_hps()
	stats.stat_changed.connect(on_stat_change)
	bebe()
	print("bebe?")
func _physics_process(_delta: float) -> void:
	#print(effects >> StatusEffect.EffectIndex.Speedy)
	process_inputs()
	if direction:
		former_direction = direction
	if Input.is_action_just_pressed("bomb"):

		if Input.is_action_pressed("dash"):
			$EffectComponent.do_effect(StatusEffect.new(StatusEffect.EffectIndex.Slowed, 5))
		elif Input.is_key_pressed(KEY_G):
			$EffectComponent.do_effect(StatusEffect.new(StatusEffect.EffectIndex.Berserk, 5))
		else:
			$EffectComponent.do_effect(StatusEffect.new(StatusEffect.EffectIndex.Speedy, 5))
	$Label.text = ""
	for effect in $EffectComponent.effects:
		$Label.text += "%s " % effect.name
	velocity_component.snap_to_dir(direction)
	former_velocity = velocity
	velocity = velocity_component.velocity
	move_and_slide()

func process_inputs() -> void:
	direction =  Input.get_vector("left", "right", "up", "down").rotated(sprite.rotation)

func recalculate_aps() -> void:
	attacks_per_sec = (1.0 + 3.5 * (effects >> StatusEffect.EffectIndex.Berserk & 1)) * 6.5 * (stats.stats["dex"] + 17.3) / 75
func recalculate_hps() -> void:
	hps = 0.24 * (stats.stats["vit"] + 4.2)
func recalculate_mps() -> void:
	mps = 0.12 * (stats.stats["wis"] + 4.2)
func recalculate_tps() -> void:
	velocity_component.max_velocity = 5.6 * (stats.stats["spd"] + 53.5) / 75 * Constants.TILE_SIZE * (1.0 + 0.5 * (effects >> StatusEffect.EffectIndex.Speedy & 1))
	if effects >> StatusEffect.EffectIndex.Slowed & 1:
		velocity_component.max_velocity = 5.6 * (53.5 / 75) * Constants.TILE_SIZE
func on_stat_change(which: String, _val: int) -> void:
	match which:
		"spd":
			recalculate_tps()
		"dex":
			recalculate_aps()
		_ :
			print(which)


func _on_button_pressed() -> void:
	stats.set_stat("dex", stats.stats["dex"] + 5)


func _on_button_2_pressed() -> void:
	stats.set_stat("dex", stats.stats["dex"] - 5)


func _on_hurtbox_hit(who: Hitbox, how_much: int, _effects: int) -> void:
	prints(who, how_much, _effects)

func _on_add(which: int) -> void:
	effects |= which

func _on_remove(which: int) -> void:
	effects &= ~which

func set_effects(which: int) -> void:
	super.set_effects(which)
	recalculate_tps()
	#recalculate_dmg()
	recalculate_hps()
	recalculate_mps()
	recalculate_aps()

func bebe() -> void:
	print("bebe!")


func on_enter_idle() -> void:
	var angle = sprite.transform.x.angle_to(former_direction)

	if angle >= -3*PI/4 and angle <= -PI/4:
		sprite.play("idle_up")
	elif angle <= PI/4 or abs(angle) > 0.01 + 3*PI/4:
		sprite.play("idle_right")
	else:
		sprite.play("idle_down")
	sprite.flip_h = abs(angle) > PI/2 and sprite.animation == "idle_right"

func _process_idle(_delta: float) -> void:

	var angle := sprite.transform.x.angle_to(former_direction)
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
