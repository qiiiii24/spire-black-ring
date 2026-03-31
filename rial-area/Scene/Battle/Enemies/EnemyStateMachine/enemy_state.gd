extends Node
class_name EnemyState
## 可用状态 一个基础状态和一个执行动作的状态
enum State {BASE, ATTACK, BLOCK}
## 基于条例（血量一半） 基于概率
enum Type {NONE, CONDITIONAL, CHANCE_BASED}
## 转换状态发出的信号
signal transition_requested(from: EnemyState, to: EnemyState.State)

@export var state: State
@export var intent: Intent
@export var sound: AudioStream
@export var type: Type
@export_range(0.0, 10.0) var chance_weight := 0.0

@onready var accumulated_weight := 0.0

var enemy: Enemy
var target: Node2D


func enter() -> void:
	enemy.intent_ui.update_intent(intent)
	
	


func exit() -> void:
	pass


func post_enter() -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func process(_delta: float) -> void:
	pass

func is_performable() -> bool:
	return false


func perform_action() -> void:
	pass

func get_anim_time(sprite: AnimatedSprite2D, anim: String) -> float:
	var frames = sprite.sprite_frames
	var fps = frames.get_animation_speed(anim)
	var count = frames.get_frame_count(anim)
	return count / (fps * sprite.speed_scale)
