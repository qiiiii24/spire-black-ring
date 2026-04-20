extends Control
class_name CardTooltipPopup

const CARD_MENU_UI = preload("uid://q5nwpn0mdido")

@export var background_color: Color = Color("000000b0")

@onready var back_ground: ColorRect = %BackGround
@onready var tooltip_card: CenterContainer = %TooltipCard
@onready var card_description: RichTextLabel = %CardDescription

func _ready() -> void:
	for card: CardMenuUI in tooltip_card.get_children():
		card.queue_free()
		
	back_ground.color = background_color
	
	#hide_tooltip()
	#await get_tree().create_timer(1).timeout
	#show_tooltip(preload("res://CharacterCard/Knight/Cards/knight_attack.tres"))


func show_tooltip(card: Card) -> void:
	var new_card := CARD_MENU_UI.instantiate() as CardMenuUI
	tooltip_card.add_child(new_card)
	new_card.card = card
	new_card.tooltip_requested.connect(hide_tooltip.unbind(1))
	card_description.text = card.get_default_tooltip()
	show()


func hide_tooltip() -> void:
	if not visible:
		return

	for card: CardMenuUI in tooltip_card.get_children():
		card.queue_free()
	
	hide()


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		hide_tooltip()
