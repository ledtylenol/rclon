extends Item
class_name Equipment


@export var name: String
@export_multiline var description: String

@export var texture: AtlasTexture
@export_group("Equipment Params")
@export var stats: Dictionary = {
	"dex": 0,
	"spd": 0,
	"att": 0,
	"vit": 0,
	"wis": 0,
	"def": 0,
	"mp": 0,
	"hp": 0,
}
