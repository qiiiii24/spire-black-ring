extends Node
class_name EnemyAction

## 有条件触发（半血触发）   随机的
enum Type {CONDITIONAL, CHANCE_BASED}

enum AttackState {
	IDLE,
	STARTUP,   # 前摇（可弹反）
	ACTIVE,    # 命中帧
	RECOVERY,  # 后摇
	INTERRUPTED
}

var state: AttackState = AttackState.IDLE
var can_be_parried := false
var is_interrupted := false

@export var intent: Intent
@export var sound: AudioStream
@export var type: Type
@export_range(0.0, 10.0) var chance_weight := 0.0

@onready var accumulated_weight := 0.0

var enemy: Enemy
var target: Node2D


func is_performable() -> bool:
	return false


func perform_action() -> void:
	pass

func get_anim_time(sprite: AnimatedSprite2D, anim: String) -> float:
	var frames = sprite.sprite_frames
	var fps = frames.get_animation_speed(anim)
	var count = frames.get_frame_count(anim)
	return count / (fps * sprite.speed_scale)

func wait_time(t: float) -> void:
	await get_tree().create_timer(t).timeout


func wait_anim(sprite: AnimatedSprite2D, anim: String) -> void:
	await sprite.animation_finished


func move_to(pos: Vector2) -> void:
	var tween = create_tween()
	await tween.tween_property(enemy, "global_position", pos, 0.4).finished
