extends Node2D

const BATTLE = preload("uid://cw2bqi2hyo0r7")
const SHOP_UI = preload("uid://c8n8xc6bxb4hv")

@export var run_startup : RunStartup

@onready var gold_ui: GoldUI = %GoldUI
@onready var current_view: Node = $CurrentView
@onready var deck_button: CardPileOpener = %DeckButton
@onready var deck_view: CardPileView = %DeckView

var character: CharacterStats
var stats : RunStats

func _ready() -> void:
	#Events.start_battle.connect(start_battle, CONNECT_DEFERRED) 这个要改
	
	if not run_startup:
		print("没有startup")
		return
	
	match run_startup.type:
		RunStartup.Type.NEW_GAME:
			character = run_startup.picked_character.create_instance()
			_start_run()
		RunStartup.Type.CONTINUED_GAME:
			print("以后完成")

func _start_run() -> void:
	stats = RunStats.new()
	_setup_event_connections()
	_setup_top_bar()
	
	await get_tree().create_timer(2).timeout
	stats.gold += 55


func _change_view(scene: PackedScene = null) -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	if not scene:
		return
	# 暂停
	#get_tree().paused = false
	var new_view := scene.instantiate()
	current_view.add_child(new_view) 


func _setup_event_connections() -> void:
	Events.enter_shop.connect(_change_view.bind(SHOP_UI))
	
	Events.enter_battle.connect(_change_view.bind(BATTLE))
	Events.exit_battle.connect(_change_view)
	## 统一退出
	Events.exit_interact.connect(_change_view)

func _setup_top_bar() -> void:
	gold_ui.run_stats = stats
	deck_button.card_pile = character.deck
	deck_view.card_pile = character.deck
	deck_button.pressed.connect(deck_view.show_current_view.bind("已有手牌"))
