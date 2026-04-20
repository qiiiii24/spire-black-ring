extends CharacterBody2D
class_name Character

var direction : Vector2
var facing: int = 1 # 1=右, -1=左
var current_interactable: Interactable = null : set = _set_intarctable

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var char_state_machine: CharStateMachine = $CharStateMachine
@onready var interaction_icon: AnimatedSprite2D = $InteractionIcon

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and current_interactable:
		current_interactable.interact(self)
	if event.is_action_pressed("exit_interact") and current_interactable: #通过按键退出交互
		current_interactable.exit_interact(self)

func _ready() -> void:
	char_state_machine.init(self)

func _process(delta: float) -> void:
	char_state_machine.physics_process(delta)
	direction = Input.get_vector("left","right","up","down").normalized()

func _physics_process(delta: float) -> void:
	char_state_machine.process(delta)
	move_and_slide()

func _set_intarctable(value: Interactable) -> void:
	current_interactable = value
	if current_interactable == null: #没有交互对象也退出交互
		Events.exit_interact.emit()

func update_facing():
	if direction.x != 0:
		facing = sign(direction.x)

func update_visual():
	animated_sprite_2d.flip_h = facing < 0

func show_interacter(is_visible: bool) -> void:
	interaction_icon.visible = is_visible
