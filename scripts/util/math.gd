extends Object
class_name Math

static func smooth_nudgev(start: Vector2, end: Vector2, weight: float, delta: float) -> Vector2:
	return start.lerp(end, 1.0 - exp(-weight * delta))
static func smooth_nudgesv(start: Vector2, end: Vector2, weight: float, delta: float) -> Vector2:
	return start.slerp(end, 1.0 - exp(-weight * delta))
static func smooth_nudgef(start: float, end: float, weight: float, delta: float) -> float:
	return lerpf(start, end, 1.0 - exp(-weight * delta))
static func smooth_nudge_angle(start: float, end: float, weight: float, delta: float) -> float:
	return lerp_angle(start, end, 1.0 - exp(-weight * delta))
