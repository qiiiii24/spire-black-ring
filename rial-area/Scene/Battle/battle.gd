extends Node2D
#class_name Battle

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI
@onready var player: Player = $Player
@onready var player_handler: PlayerHandler = $PlayerHandler

var mana_timer := 0.0

func _ready() -> void:
	var new_stats: CharacterStats = char_stats.create_instance()
	
	battle_ui.char_stats = new_stats
	player.stats = new_stats
	start_battle(new_stats)

func start_battle(stats: CharacterStats) -> void:
	#get_tree().paused = false
	
	battle_ui.char_stats = stats
	player.stats = stats
	player_handler.start_battle(stats)

func _process(delta: float) -> void:
	mana_timer += delta
	
	if mana_timer >= 1.0:
		mana_timer -= 1.0
		player.stats.mana += 1
