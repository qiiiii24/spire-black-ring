extends Node2D
#class_name Battle

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI
@onready var player: Player = $Player

func _ready() -> void:
	var new_stats: CharacterStats = char_stats.create_instance()
	
	battle_ui.char_stats = new_stats
	player.stats = new_stats
	#start_battle(new_stats)

func start_battle(stats: CharacterStats) -> void:
	get_tree().paused = false
	
	battle_ui.char_stats = stats
	player.stats = stats
