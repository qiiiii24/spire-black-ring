extends HBoxContainer
class_name StatsUI

@onready var block_ui: HBoxContainer = $BlockUI
@onready var block_label: Label = %BlockLabel
@onready var health: HealthUI = $HealthUI
@onready var level_ui: HBoxContainer = $LevelUI
@onready var level_label: Label = $LevelUI/LevelLabel



func update_stats(stats: Stats) -> void:
	block_label.text = str(stats.block)
	health.update_stats(stats)
	
	block_ui.visible = stats.block > 0
	health.visible = stats.health > 0
	
	if stats is CharacterStats:
		var character_stats := stats as CharacterStats
		level_ui.visible = true
		level_label.text = str(character_stats.level)
	else:
		level_ui.visible = false
