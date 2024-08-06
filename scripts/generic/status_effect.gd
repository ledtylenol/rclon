extends Resource
class_name StatusEffect
enum EffectIndex {
	Dead = 0,
	Quiet = 1,
	Weak = 2,
	Slowed = 3,
	Sick = 4,
	Dazed = 5,
	Stunned = 6,
	Blind = 7,
	Hallucinating = 8,
	Drunk = 9,
	Confused = 10,
	StunImmune = 11,
	Invisible = 12,
	Paralyzed = 13,
	Speedy = 14,
	Bleeding = 15,
	NotUsed = 16,
	Healing = 17,
	Damaging = 18,
	Berserk = 19,
	Paused = 20,
	Stasis = 21,
	StasisImmune = 22,
	Invincible = 23,
	Invulnerable = 24,
	Armored = 25,
	ArmorBroken = 26,
	Hexed = 27,
	ParalyzedImmune = 28
}
var effect: EffectIndex = 0
var duration: float
var name: String
signal queue_remove
signal queue_add
func _init(effect: EffectIndex, duration: float ) -> void:
	self.effect = effect
	self.duration = duration
	name = "%s" % EffectIndex.find_key(effect)
func get_effect() -> int:
	return 1 << effect
func tick(delta: float) -> void:
	self.duration -= delta
	print(duration)
	if duration < 0.0:
		self.queue_remove.emit(self, 1 << effect)
