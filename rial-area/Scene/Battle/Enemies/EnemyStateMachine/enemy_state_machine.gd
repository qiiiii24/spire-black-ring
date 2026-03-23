extends Node
class_name EnemyStateMachine

@export var initial_state: EnemyState

var current_state: EnemyState
var states := {}


func init(enemy: Enemy) -> void:
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
