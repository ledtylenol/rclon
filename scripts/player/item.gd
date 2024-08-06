extends Resource
class_name Item

enum Bags {
	Basic,
	Soulbound,
	Uncommon,
	Rare,
	Arcane
}

@export var bag_type: Bags
