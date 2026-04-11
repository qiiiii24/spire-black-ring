extends Node
class_name CharState

## 可用状态 一个基础状态和一个执行动作的状态
enum State {IDLE,WALK}
## 转换状态发出的信号
signal transition_requested(from: CharState, to: State)

@export var state: State

var charcter: Character


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
