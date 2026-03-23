extends Area2D
class_name Enemy

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine

func _ready() -> void:
	enemy_state_machine.init(self)

func _physics_process(delta: float) -> void:
	enemy_state_machine.physics_process(delta)

func _process(delta: float) -> void:
	enemy_state_machine.process(delta)
