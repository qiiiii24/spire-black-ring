extends EnemyState

@export var damage := 4

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
	var sprite : AnimatedSprite2D = enemy.animated_sprite_2d
	var tween := create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 128
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	#damage_effect.sound = sound
	
	#tween.tween_property(enemy, "global_position", end, 0.4)
	
	tween.tween_callback(sprite.play.bind("attack"))
	tween.tween_interval(get_anim_time(sprite, "attack"))
	tween.tween_callback(damage_effect.execute.bind(target_array))
	
	
	tween.tween_callback(sprite.play.bind("attack2"))
	tween.tween_interval(get_anim_time(sprite, "attack2"))
	tween.tween_callback(damage_effect.execute.bind(target_array))
	
	tween.tween_callback(sprite.play.bind("idle"))
	#tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func():
			transition_requested.emit(self,EnemyState.State.BASE)
			Events.enemy_action_completed.emit(enemy)
			)
