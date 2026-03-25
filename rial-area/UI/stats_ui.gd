extends HBoxContainer
class_name StatsUI

@onready var block_ui: HBoxContainer = $BlockUI
@onready var block_label: Label = %BlockLabel
@onready var health: HealthUI = $HealthUI


func update_stats(stats: Stats) -> void:
	block_label.text = str(stats.block)
	health.update_stats(stats)
	
	block_ui.visible = stats.block > 0
	health.visible = stats.health > 0
