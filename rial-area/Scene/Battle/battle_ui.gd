extends CanvasLayer
class_name BattleUI

@export var char_stats: CharacterStats : set = _set_char_stats

@onready var hand: Hand = $Hand
@onready var mana_ui: ManaUI = $ManaUI

@onready var draw_pile_button: CardPileOpener = %DrawPileButton
@onready var discard_pile_button: CardPileOpener = %DiscardPileButton
@onready var draw_pile_view: CardPileView = %DrawPileView
@onready var discard_pile_view: CardPileView = %DiscardPileView

func _ready() -> void:
	draw_pile_button.pressed.connect(draw_pile_view.show_current_view.bind("抽牌堆",true))
	discard_pile_button.pressed.connect(discard_pile_view.show_current_view.bind("弃牌堆"))

func initialize_card_pile_ui() -> void:
	draw_pile_button.card_pile = char_stats.draw_pile
	draw_pile_view.card_pile = char_stats.draw_pile
	discard_pile_button.card_pile = char_stats.discard
	discard_pile_view.card_pile = char_stats.discard

func _set_char_stats(value: CharacterStats) -> void:
	char_stats = value
	if char_stats == null:
		return
	mana_ui.char_stats = char_stats
	hand.char_stats = char_stats
