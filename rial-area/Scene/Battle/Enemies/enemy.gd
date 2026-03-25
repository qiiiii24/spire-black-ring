extends Area2D
class_name Enemy

@export var stats: EnemyStats : set = set_enemy_stats

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var stats_ui: StatsUI = $StatsUI

func _ready() -> void:
	enemy_state_machine.init(self)

func _physics_process(delta: float) -> void:
	enemy_state_machine.physics_process(delta)

func _process(delta: float) -> void:
	enemy_state_machine.process(delta)


func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		
	update_enemy()

func update_stats() -> void:
	stats_ui.update_stats(stats)

func update_enemy() -> void:
	if not stats is Stats: 
		return
	if not is_inside_tree(): 
		await ready
	
	animated_sprite_2d.sprite_frames = stats.art
	#arrow.position = Vector2.RIGHT * (sprite_2d.get_rect().size.x / 2 + ARROW_OFFSET)
	#setup_ai()
	update_stats()
