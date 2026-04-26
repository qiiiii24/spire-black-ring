extends Control

const GOLD_ICON = preload("uid://ckhm1uv0xf68l")
const RARITY = preload("uid://crvyj5u3ynmij")
const GOLD_TEXT := "%s gold"
const CARD_TEXT := "Add New Card"
const REWARD_BUTTON = preload("uid://pfo48mb677qk")

@export var run_stats: RunStats

@onready var rewards: VBoxContainer = %Rewards

func _ready() -> void:
	for node: Node in rewards.get_children():
		node.queue_free()
	
	run_stats = RunStats.new()
	run_stats.gold_change.connect(func():print("gold: %s"%run_stats.gold))
	
	add_gold_reward(88)

func add_gold_reward(amount: int) -> void:
	var gold_reward := REWARD_BUTTON.instantiate() as RewardButton
	gold_reward.reward_icon = GOLD_ICON
	gold_reward.reward_text = GOLD_TEXT % amount
	gold_reward.pressed.connect(_on_gold_reward_taken.bind(amount))
	rewards.add_child.call_deferred(gold_reward) # 帧结束时发生

func _on_gold_reward_taken(amount: int) -> void:
	if not run_stats:
		return
	
	run_stats.gold += amount

func _on_back_button_pressed() -> void:
	Events.exit_interact.emit()
