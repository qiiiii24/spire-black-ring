extends CanvasLayer
class_name BattleUI

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var hand: Hand = $Hand

func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	if char_stats == null:
		return
	#mana_ui.char_stats = char_stats
	hand.char_stats = char_stats
