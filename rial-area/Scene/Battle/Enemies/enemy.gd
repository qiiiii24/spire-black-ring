extends Area2D
class_name Enemy

const ARROW_OFFSET := 5

@export var stats: EnemyStats : set = set_enemy_stats

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2d
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var stats_ui: StatsUI = $StatsUI
@onready var arrow: Sprite2D = $Arrow
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var intent_ui: IntentUI = $IntentUI

#var current_state: EnemyState : set = set_current_state

func _ready() -> void:
	enemy_state_machine.init(self)
	#update_state()

func _physics_process(delta: float) -> void:
	enemy_state_machine.physics_process(delta)

func _process(delta: float) -> void:
	enemy_state_machine.process(delta)


func set_enemy_stats(value: EnemyStats) -> void:
	stats = value.create_instance()
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		
	update_enemy()


func update_enemy() -> void:
	if not stats is Stats: 
		return
	if not is_inside_tree(): 
		await ready
	
	animated_sprite_2d.sprite_frames = stats.art
	arrow.position = Vector2.RIGHT * (collision_shape_2d.shape.size.x / 2 + ARROW_OFFSET)
	setup_ai()
	update_stats()

func setup_ai() -> void:
	enemy_state_machine.enemy = self

func update_stats() -> void:
	stats_ui.update_stats(stats)

#func update_state() -> void:
	#if not enemy_state_machine:
		#return
	#
	#if not current_state:
		#current_state = enemy_state_machine.get_state()
		#return
	#
	#var new_conditional_state := enemy_state_machine.get_first_conditional_state()
	#if new_conditional_state and current_state != new_conditional_state:
		#current_state = new_conditional_state

#func set_current_state(value: EnemyState) -> void:
	#current_state = value
	#if current_state:
		#intent_ui.update_intent(current_state.intent)

func take_damage(damage: int) -> void:
	if stats.health <= 0:
		return
	
	#sprite_2d.material = WHITE_SPRITE_MATERIAL
	
	var tween := create_tween()
	#tween.tween_callback(Shaker.shake.bind(self, 16, 0.15))
	tween.tween_callback(stats.take_damage.bind(damage))
	tween.tween_interval(0.17)

	tween.finished.connect(
		func():
			#sprite_2d.material = null
			
			if stats.health <= 0:
				queue_free()
				Events.enemy_died.emit(self)
				)

func _on_area_entered(_area: Area2D) -> void:
	arrow.show()

func _on_area_exited(_area: Area2D) -> void:
	arrow.hide()
