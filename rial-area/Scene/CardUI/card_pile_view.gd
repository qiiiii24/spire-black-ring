extends Control
class_name CardPileView

const CARD_MENU_UI = preload("uid://q5nwpn0mdido")

@export var card_pile: CardPile

@onready var title: Label = %Title
@onready var back_button: Button = %BackButton
@onready var card_tooltip_popup: CardTooltipPopup = %CardTooltipPopup
@onready var cards: GridContainer = %Cards

func _ready() -> void:
	back_button.pressed.connect(hide) # 连接hide
	
	for card: Node in cards.get_children(): # 删除占位符
		card.queue_free()
	
	card_tooltip_popup.hide_tooltip() # 调用一次hide_tooltip防止一打开就显示popup
	
	#await get_tree().create_timer(2).timeout
	#card_pile = preload("res://CharacterCard/Knight/Knight_card_pile.tres")
	#show_current_view("抽牌堆",true)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if card_tooltip_popup.visible: # 如果popup显示就关闭
			card_tooltip_popup.hide_tooltip()
		else: # 关闭卡牌堆视图
			hide()

# 
func show_current_view(new_title: String, randomized: bool = false) -> void:
	for card: Node in cards.get_children():
		card.queue_free()
		
	card_tooltip_popup.hide_tooltip()
	title.text = new_title
	_update_view.call_deferred(randomized)


func _update_view(randomized: bool) -> void:
	if not card_pile:
		return
	
	var all_cards := card_pile.cards.duplicate()
	if randomized:
		all_cards.shuffle()
	
	for card: Card in all_cards:
		var new_card := CARD_MENU_UI.instantiate() as CardMenuUI
		cards.add_child(new_card)
		new_card.card = card
		new_card.tooltip_requested.connect(card_tooltip_popup.show_tooltip)
		
	show()
