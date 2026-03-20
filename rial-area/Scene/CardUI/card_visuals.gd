extends Control
class_name CardVisuals

@export var card: Card : set = set_card

@onready var panel: TextureRect = $Panel
@onready var description_label: Label = $Description/DescriptionLabel
@onready var card_name_label: Label = $CardName/CardNameLabel
@onready var cost_label: Label = $Cost/CostLabel
@onready var type_icon: TextureRect = $Type/TypeIcon
@onready var icon: TextureRect = $Frame/Icon

func set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	
	card = value
	
	icon.texture = card.icon
	type_icon.texture = card.type_icon
	cost_label.text = str(card.cost)
	card_name_label.text = card.card_name
	description_label.text = card.tooltip_text
	
