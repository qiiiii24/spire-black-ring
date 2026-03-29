extends Area2D
class_name Enemy

const ARROW_OFFSET := 5

@export var stats: EnemyStats : set = set_enemy_stats

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine
@onready var stats_ui: StatsUI = $StatsUI
@onready var arrow: Sprite2D = $Arrow
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var enemy_action_picker: EnemyActionPicker = $EnemyActionPicker
@onready var intent_ui: IntentUI = $IntentUI

var current_action: EnemyAction : set = set_current_action

func _ready() -> void:
	enemy_state_machine.init(self)
	update_action()
	
	await get_tree().create_timer(3).timeout
	current_action.perform_action()

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
	enemy_action_picker.enemy = self

func update_stats() -> void:
	stats_ui.update_stats(stats)

func update_action() -> void:
	if not enemy_action_picker:
		return
	
	if not current_action:
		current_action = enemy_action_picker.get_action()
		return
	
	var new_conditional_action := enemy_action_picker.get_first_conditional_action()
	if new_conditional_action and current_action != new_conditional_action:
		current_action = new_conditional_action

func set_current_action(value: EnemyAction) -> void:
	current_action = value
	if current_action:
		intent_ui.update_intent(current_action.intent)

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
				)

func _on_area_entered(_area: Area2D) -> void:
	arrow.show()

func _on_area_exited(_area: Area2D) -> void:
	arrow.hide()
