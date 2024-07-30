extends CharacterBody2D
class_name Player

#stats
@export var stats: PlayerStats
var status_effects: int = 0:
	set(value):
		status_effects = value
		recalculate_aps()
		recalculate_tps()
var weapon := PlayerWeapon
var ability := PlayerAbility
var armor := PlayerArmor
var ring := PlayerRing
@onready var velocity_component: VelocityComponent = $VelocityComponent
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
	status_effects |= 1
	stats.stat_changed.connect(on_stat_change)
func _physics_process(delta: float) -> void:
	process_inputs()
	if direction:
		former_direction = direction
	velocity_component.snap_to_dir(direction)
	former_velocity = velocity
	velocity = velocity_component.velocity
	move_and_slide()

func process_inputs() -> void:
	direction =  Input.get_vector("left", "right", "up", "down").rotated(sprite.rotation)

func recalculate_aps() -> void:
	attacks_per_sec = 6.5 * (stats.stats["dex"] + 17.3) / 75
func recalculate_hps() -> void:
	hps = 0.24 * (stats.stats["vit"] + 4.2)
func recalculate_mps() -> void:
	mps = 0.12 * (stats.stats["wis"] + 4.2)
func recalculate_tps() -> void:
	velocity_component.max_velocity = 5.6 * (stats.stats["spd"] + 53.5) / 75 * Constants.TILE_SIZE * (1.0 + 0.5 * (status_effects & Constants.SPEEDY))

func on_stat_change(which: String, val: int) -> void:
	match which:
		"spd":
			recalculate_tps()
		"dex":
			recalculate_aps()
		_ :
			print(which)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("bomb") and event.is_pressed():
		status_effects |= Constants.SPEEDY
		await get_tree().create_timer(1.0).timeout
		status_effects ^= Constants.SPEEDY


func _on_button_pressed() -> void:
	stats.set_stat("dex", stats.stats["dex"] + 5)


func _on_button_2_pressed() -> void:
	stats.set_stat("dex", stats.stats["dex"] - 5)
