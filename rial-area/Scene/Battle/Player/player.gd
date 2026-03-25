extends Node2D
class_name Player

@export var stats: CharacterStats : set = set_character_stats

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats_ui: StatsUI = $StatsUI

func set_character_stats(value: CharacterStats) -> void:
	stats = value
	if stats == null:
		return
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)

	update_player()

## 更新玩家的图片
func update_player() -> void:
	if not stats is CharacterStats: 
		return
	if not is_inside_tree(): 
		await ready
	
	if stats == null:
		return
	animated_sprite_2d.sprite_frames = stats.art
	update_stats()

## 更新玩家状态
func update_stats() -> void:
	stats_ui.update_stats(stats)
