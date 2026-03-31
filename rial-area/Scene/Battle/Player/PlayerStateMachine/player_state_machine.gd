extends Node
class_name PlayerStateMachine

@export var initial_state: PlayerState

var current_state: PlayerState
var states := {}


func init(player: Player) -> void:
	for child: PlayerState in get_children():
		if child:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.player = player
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)

func process(delta: float) -> void:
	if current_state:
		current_state.process(delta)


func _on_transition_requested(from: PlayerState, to: PlayerState.State) -> void:
	if from != current_state:
		return
	
	var new_state: PlayerState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	new_state.post_enter()
