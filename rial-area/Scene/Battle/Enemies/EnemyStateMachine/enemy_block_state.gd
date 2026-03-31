extends EnemyState

@export var block := 4

func enter() -> void:
	super.enter()
	var cd := intent.get_cooldown_time()
	enemy.intent_ui.start_cooldown(cd)
	await get_tree().create_timer(cd).timeout
	
	if enemy.enemy_state_machine.current_state != self:
		return
	perform_action()

func perform_action() -> void:
	if not enemy or not target:
		return
	
	var block_effect := BlockEffect.new()
	block_effect.amount = block
	#block_effect.sound = sound
	block_effect.execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			transition_requested.emit(self, EnemyState.State.BASE)
			Events.enemy_action_completed.emit(enemy)
			)
	
