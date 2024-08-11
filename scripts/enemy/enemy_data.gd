extends Resource
class_name EnemyData

@export var animation: SpriteFrames
@export var stats := {
	"health": 100,
	"aps": 1.0,
	"pattern": preload("res://scenes/bullets/bullet_group.tscn")
}
