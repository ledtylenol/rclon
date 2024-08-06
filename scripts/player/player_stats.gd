extends Resource
class_name PlayerStats

@export var distance_walked := 0.0
@export var enemies_killed := 0
@export var damage_dealt := 0
@export var damage_taken := 0
@export var experience := 0


signal stat_changed(which: String, value: int)
@export_group("Stats")
@export var stats:  Dictionary = {
	"dex": 17,
	"spd": 17,
	"att": 17,
	"vit": 5,
	"wis": 23,
	"def": 0,
	"mp": 0,
	"hp": 0,
}

func set_stat(which: String, value: int) -> void:
	stat_changed.emit(which, value)
	stats[which] = value
