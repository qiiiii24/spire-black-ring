extends Resource
class_name Intent

@export var number: String
@export var icon: Texture
@export var cooldown_range := Vector2(1.0, 3.0)

func get_cooldown_time() -> float:
	return randf_range(cooldown_range.x, cooldown_range.y)
