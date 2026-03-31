extends HBoxContainer
class_name IntentUI

@onready var intent_icon: TextureRect = $IntentIcon
@onready var number: Label = $Number
@onready var cool_down_timer: ColorRect = $CoolDownTimer

var cooldown_tween: Tween

#func _ready() -> void:
	#start_cooldown(3)

func update_intent(intent: Intent) -> void:
	if not intent:
		hide()
		return
	
	intent_icon.texture = intent.icon
	intent_icon.visible = intent_icon.texture != null
	number.text = str(intent.number)
	number.visible = intent.number.length() > 0
	show()

func start_cooldown(cooldowntime: float) -> void:
	if cooldown_tween:
		cooldown_tween.kill()
	
	var mat := cool_down_timer.material as ShaderMaterial
	if mat == null:
		push_error("cool_down_timer 上没有 ShaderMaterial")
		return
	
	if cooldowntime <= 0.0:
		mat.set_shader_parameter("stamina", 0.0)
		cool_down_timer.visible = false
		return
	
	cool_down_timer.visible = true
	mat.set_shader_parameter("stamina", 0.0)
	
	cooldown_tween = create_tween()
	cooldown_tween.tween_method(
		func(value: float):
			if mat:
				mat.set_shader_parameter("stamina", value),
		0.0,
		1.0,
		cooldowntime
	)
	
	cooldown_tween.finished.connect(func():
		#mat.set_shader_parameter("stamina", 0.0)
		cool_down_timer.visible = false
		cooldown_tween = null
		)

func stop_cooldown() -> void:
	if cooldown_tween:
		cooldown_tween.kill()
		cooldown_tween = null
	
	var mat := cool_down_timer.material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("stamina", 0.0)
	
	cool_down_timer.visible = false
