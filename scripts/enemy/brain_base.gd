extends Node2D
class_name BrainBase

var direction := Vector2.ZERO
var distance := 0.0
var target: Node2D
var time := 5.0
@export var health_component: HealthComponent
var behaviors := {}
@export_file("*.googus") var behavior_file: String
func _ready() -> void:
	behaviors = PredicateParser.get_predicate(self, behavior_file)

func _physics_process(delta: float) -> void:
	if not target:
		return
	distance = target.global_position.distance_to(global_position)




func _on_player_detection_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body is Player:
		target = null
