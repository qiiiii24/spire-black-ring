extends Node
class_name CharStateMachine

@export var initial_state: CharState

var current_state: CharState
var states := {}


func init(charcter: Character) -> void:
	for child: CharState in get_children():
		if child:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.charcter = charcter
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)

func process(delta: float) -> void:
	if current_state:
		current_state.process(delta)


func _on_transition_requested(from: CharState, to: CharState.State) -> void:
	if from != current_state:
		return
	
	var new_state: CharState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	new_state.post_enter()
