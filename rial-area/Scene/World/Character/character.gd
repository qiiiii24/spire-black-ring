extends CharacterBody2D
class_name Character

var direction : Vector2
var facing: int = 1 # 1=右, -1=左


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var char_state_machine: CharStateMachine = $CharStateMachine

func _ready() -> void:
	char_state_machine.init(self)

func _process(delta: float) -> void:
	char_state_machine.physics_process(delta)
	direction = Input.get_vector("left","right","up","down").normalized()

func _physics_process(delta: float) -> void:
	char_state_machine.process(delta)
	move_and_slide()

func update_facing():
	if direction.x != 0:
		facing = sign(direction.x)

func update_visual():
	animated_sprite_2d.flip_h = facing < 0


func _on_hit_box_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	Events.start_battle.emit()
	parent.queue_free()
