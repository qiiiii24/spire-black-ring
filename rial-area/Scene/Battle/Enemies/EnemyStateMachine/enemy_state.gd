extends Node
class_name EnemyState
## 可用状态 一个基础状态和一个执行动作的状态
enum State {BASE, ACTION}
## 转换状态发出的信号
signal transition_requested(from: EnemyState, to: State)

@export var state: State

var enemy: Enemy


func enter() -> void:
	pass


func exit() -> void:
	pass


func post_enter() -> void:
	pass

func physics_process(_delta: float) -> void:
	pass

func process(_delta: float) -> void:
	pass
