extends Node2D
class_name BrainBase

var direction := Vector2.ZERO
var distance := 0.0
var target: Node2D
var time := 5.0
var behaviors := {}
var parent := Node2D
var velocity_comp: VelocityComponent
var can_shoot := false: get = can_shoot
var cooldown := 0.0
@export var health_component: HealthComponent
@export_file("*.googus") var behavior_file: String
@export var detection_node: Area2D
func _ready() -> void:
	behaviors = PredicateParser.get_predicate(self, behavior_file)
	if parent and parent.velocity_component:
		velocity_comp = parent.velocity_component
func _physics_process(delta: float) -> void:
	if not target:
		return
	distance = target.global_position.distance_to(parent.global_position)
	if target and can_shoot:
		shoot.emit()
	if not parent.velocity_component:
		return
	var dir := Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	velocity_comp.snap_to_dir(dir)



func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		target = null

func can_shoot() -> bool:
	return target != null and cooldown <= 0.0
