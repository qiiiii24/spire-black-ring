extends Node
class_name PlayerState

## 可用状态 一个基础状态和一个执行动作的状态
enum State {BASE, PREPARE, ACTION}
## 转换状态发出的信号
signal transition_requested(from: PlayerState, to: State)

@export var state: State

var player: Player


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
