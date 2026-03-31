extends EnemyState

func enter() -> void:
	super.enter()
	if not is_node_ready():
		await ready
	
	enemy.animated_sprite_2d.play("idle")
	var random_time := randf_range(1,2)
	await get_tree().create_timer(random_time).timeout
	var new_state: EnemyState = enemy.enemy_state_machine.get_state()
	
	transition_requested.emit(self,new_state.state)
