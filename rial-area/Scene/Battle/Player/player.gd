extends Node2D
class_name Player

@export var stats: CharacterStats : set = set_character_stats

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var stats_ui: StatsUI = $StatsUI
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine

var mana_timer := 0.0

func _ready() -> void:
	player_state_machine.init(self)

func _process(delta: float) -> void:
	player_state_machine.process(delta)

func _physics_process(delta: float) -> void:
	player_state_machine.physics_process(delta)

func set_character_stats(value: CharacterStats) -> void:
	stats = value
	if stats == null:
		return
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)

	update_player()

## 更新玩家的图片
func update_player() -> void:
	if not stats is CharacterStats: 
		return
	if not is_inside_tree(): 
		await ready
	
	if stats == null:
		return
	animated_sprite_2d.sprite_frames = stats.art
	
	update_stats()

## 更新玩家状态
func update_stats() -> void:
	stats_ui.update_stats(stats)

func add_mana(delta: float) -> void:
	mana_timer += delta
	
	if mana_timer >= 1.0:
		mana_timer -= 1.0
		stats.mana += 1

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
				Events.player_died.emit()
				queue_free()
				)
		
