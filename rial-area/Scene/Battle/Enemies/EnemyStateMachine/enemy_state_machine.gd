extends Node
class_name EnemyStateMachine

@export var initial_state: EnemyState

@export var enemy: Enemy: set = _set_enemy
@export var target: Node2D: set = _set_target

@onready var total_weight := 0.0

var current_state: EnemyState
var states := {}


func init(enemy: Enemy) -> void:
	target = get_tree().get_first_node_in_group("player")
	setup_chances()
	
	for child: EnemyState in get_children():
		if child:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.enemy = enemy
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)

func process(delta: float) -> void:
	if current_state:
		current_state.process(delta)


func _on_transition_requested(from: EnemyState, to: EnemyState.State) -> void:
	if from != current_state:
		return
		
	var new_state: EnemyState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	new_state.post_enter()


## 获取新动作 先获取基于条件的 有的话直接返回 没有再获取基于概率的
func get_state() -> EnemyState:
	var state := get_first_conditional_state()
	if state:
		return state
		
	return get_chance_based_state()


func get_first_conditional_state() -> EnemyState:
	for state: EnemyState in get_children():
		if not state or state.type != EnemyState.Type.CONDITIONAL:
			continue
			
		if state.is_performable(): # 满足条件
			return state
	
	return null

## 基于概率获取新state（加权随机）
func get_chance_based_state() -> EnemyState:
	var roll := randf_range(0.0, total_weight)
	
	for state: EnemyState in get_children():
		if not state or state.type != EnemyState.Type.CHANCE_BASED:
			continue
		
		if state.accumulated_weight > roll:
			return state
	
	return null

## 设置每个state的权重
func setup_chances() -> void:
	for state: EnemyState in get_children():
		if not state or state.type != EnemyState.Type.CHANCE_BASED:
			continue
		
		total_weight += state.chance_weight
		state.accumulated_weight = total_weight


func _set_enemy(value: Enemy) -> void:
	enemy = value
	
	for state: EnemyState in get_children():
		state.enemy = enemy


func _set_target(value: Node2D) -> void:
	target = value
	
	for action: EnemyState in get_children():
		action.target = target
