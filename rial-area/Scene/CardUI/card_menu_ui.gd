extends CenterContainer
class_name CardMenuUI

signal right_click(card: Card)
signal left_click(card: Card)

@export var card: Card : set = set_card

@onready var card_visuals: CardVisuals = $CardVisuals

#右键查看详细信息 ，左键选择
func _on_visuals_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		#tooltip_requested.emit(card)
		left_click.emit(card)
		print("左键点击%s" %name)
	if event.is_action_pressed("right_mouse"):
		right_click.emit(card)
		print("右键点击%s" %name)


#func _on_visuals_mouse_entered() -> void:
	#visuals.panel.set("theme_override_styles/panel", HOVER_STYLEBOX)
#
#
#func _on_visuals_mouse_exited() -> void:
	#visuals.panel.set("theme_override_styles/panel", BASE_STYLEBOX)


func set_card(value: Card) -> void:
	if not is_node_ready():
		await ready

	card = value
	card_visuals.card = card
