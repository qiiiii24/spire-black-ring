extends HBoxContainer
class_name Hand

const CARD_UI = preload("uid://cldbrqpggadi3")
const KNIGHT_ATTACK = preload("uid://boyhosihg18y3")
const KNIGHT_DEFENSE = preload("uid://cvnkmkiautmud")

func _ready() -> void:
	for i in range(4):
		add_card()

func add_card() -> void:
	var new_card_ui := CARD_UI.instantiate() as CardUI
	add_child(new_card_ui)
	new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	#new_card_ui.card = card
	new_card_ui.parent = self #新卡的父节点为hand
	var random_num := randi_range(0,1)
	new_card_ui.card = KNIGHT_ATTACK if random_num == 0 else KNIGHT_DEFENSE

func _on_card_ui_reparent_requested(child : CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	var new_index := clampi(child.original_index , 0, get_child_count())
	move_child.call_deferred(child, new_index)
	#child.set_deferred("disabled",false)#在当前帧的末尾将disabled改成false
