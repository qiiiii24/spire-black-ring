extends ColorRect
class_name CardRewards

# 卡牌奖励已选择信号
signal card_reward_selected(card: Card)

const CARD_MENU_UI = preload("uid://q5nwpn0mdido")

@export var rewards: Array[Card] : set = set_rewards

@onready var cards: HBoxContainer = %Cards
@onready var skip_card_reward: Button = %SkipCardReward
@onready var card_tooltip_popup: CardTooltipPopup = $CardTooltipPopup

var selected_card : Card

func set_rewards(new_cards: Array[Card]) -> void:
	rewards = new_cards
	
	if not is_node_ready():
		await ready
		
	_clear_rewards()
	for card: Card in rewards:
		var new_card := CARD_MENU_UI.instantiate() as CardMenuUI
		cards.add_child(new_card)
		new_card.card = card
		new_card.right_click.connect(_show_tooltip)
		new_card.left_click.connect(_select_card)

func _ready() -> void:
	_clear_rewards()
	
	skip_card_reward.pressed.connect(
		func(): 
			card_reward_selected.emit(null)
			queue_free()
			)

func _clear_rewards() -> void:
	for card: Node in cards.get_children():
		card.queue_free()
		
	card_tooltip_popup.hide_tooltip()

	selected_card = null

func _show_tooltip(card: Card) -> void:
	card_tooltip_popup.show_tooltip(card)

func _select_card(card: Card) -> void:
	selected_card = card
	card_reward_selected.emit(selected_card)
	print("选择了%s"%card.card_name)
	queue_free()
