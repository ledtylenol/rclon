extends Entity
class_name Enemy

var target: Player

@export var data: EnemyData
@export var health_component: HealthComponent
@export var drops := {
	"HPPot": 0.5,
}
func _ready() -> void:
	if health_component:
		health_component.hit
	if not data:
		push_warning("this enemy has no data")
		queue_free()
func _physics_process(delta: float) -> void:
	if velocity_component:
		velocity = velocity_component.velocity
	move_and_slide()
