extends Node2D
#class_name Battle

@export var char_stats: CharacterStats

@onready var battle_ui: BattleUI = $BattleUI
@onready var player: Player = $Player
@onready var player_handler: PlayerHandler = $PlayerHandler
@onready var pass_card_button: PassCardButton = $BattleUI/PassCardButton
@onready var enemy_handler: Node2D = $EnemyHandler



func _ready() -> void:
	var new_stats: CharacterStats = char_stats.create_instance()
	
	battle_ui.char_stats = new_stats
	player.stats = new_stats
	pass_card_button.stats = new_stats
	new_stats.stats_changed.connect(pass_card_button.update_button)
	start_battle(new_stats)
	
	Events.player_hand_drawn.connect(open_pass_button)
	Events.player_hand_discarded.connect(start_turn)
	Events.player_died.connect(_on_player_died)
	#Events.enemy_died.connect(enemy_handler.add_enemy)
	enemy_handler.child_order_changed.connect(_on_enemies_child_order_changed)
	

func start_battle(stats: CharacterStats) -> void:
	#get_tree().paused = false
	
	battle_ui.char_stats = stats
	player.stats = stats
	player_handler.start_battle(stats)

func _on_enemies_child_order_changed() -> void:
	if enemy_handler.get_child_count() == 0:
		Events.battle_over_screen_requested.emit("Victorious!", BattleOverPanel.Type.WIN)

func _on_player_died() -> void:
	Events.battle_over_screen_requested.emit("Game Over!", BattleOverPanel.Type.LOSE)

func _on_pass_card_pressed() -> void:
	player.stats.mana -= pass_card_button.stats.draw_card_cost
	pass_card_button.passing = true
	player_handler.end_turn()


func start_turn() -> void:
	player_handler.start_turn()

func open_pass_button() -> void:
	pass_card_button.passing = false
	
