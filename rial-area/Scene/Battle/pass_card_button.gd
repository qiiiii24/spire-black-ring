extends Button
class_name PassCardButton

const COST : int = 3

var stats: CharacterStats
# 正在过牌
var passing : bool = false : set = set_passing

func update_button() -> void:
	if passing:
		return
	if stats.mana >= COST:
		disabled = false
	else:
		disabled = true

func set_passing(value: bool) -> void:
	passing = value
	if passing:
		disabled = true
	else:
		if stats.mana >= COST:
			disabled = false
		else:
			disabled = true
