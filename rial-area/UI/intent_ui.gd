extends HBoxContainer
class_name IntentUI

@onready var intent_icon: TextureRect = $IntentIcon
@onready var number: Label = $Number
@onready var cool_down_timer: ColorRect = $CoolDownTimer

func update_intent(intent: Intent) -> void:
	if not intent:
		hide()
		return
	
	intent_icon.texture = intent.icon
	intent_icon.visible = intent_icon.texture != null
	number.text = str(intent.number)
	number.visible = intent.number.length() > 0
	show()
