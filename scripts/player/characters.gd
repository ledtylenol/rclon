extends Resource
class_name CharacterStats
@export var sprites: SpriteFrames
@export var starting_weapon: PlayerWeapon
@export var starting_ability: PlayerAbility
@export var starting_stats: Dictionary = {
	"dex": 17,
	"spd": 17,
	"att": 17,
	"vit": 5,
	"wis": 23,
	"def": 0,
	"mp": 0,
	"hp": 0,
}

@export var max_stats: Dictionary = {
	"dex": 75,
	"spd": 55,
	"att": 75,
	"vit": 50,
	"wis": 75,
	"def": 30,
	"mp": 130,
	"hp": 130,
}
