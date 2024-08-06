extends Entity
class_name Enemy


var target: Player
@export var drops := {
	"HPPot": 0.5,
}
func _physics_process(delta: float) -> void:
	if velocity_component:
		velocity = velocity_component.velocity
	move_and_slide()
