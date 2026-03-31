extends EnemyAction

@export var damage := 4

func perform_action() -> void:
	if not enemy or not target:
		return
	
	is_interrupted = false
	
	var sprite: AnimatedSprite2D = enemy.animated_sprite_2d
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 128
	
	var damage_effect = DamageEffect.new()
	damage_effect.amount = damage
	var target_array: Array[Node] = [target]

	await move_to(end)

	# ========================
	# 第一段攻击
	# ========================
	state = AttackState.STARTUP
	can_be_parried = true
	
	sprite.play("attack")
	await wait_time(0.2)  # 👉 弹反窗口
	
	if is_interrupted: return interrupt()

	can_be_parried = false
	state = AttackState.ACTIVE
	
	damage_effect.execute(target_array)

	await wait_anim(sprite, "attack")
	if is_interrupted: return interrupt()

	# ========================
	# 第二段攻击
	# ========================
	state = AttackState.STARTUP
	can_be_parried = true
	
	sprite.play("attack2")
	await wait_time(0.15)
	
	if is_interrupted: return interrupt()

	can_be_parried = false
	state = AttackState.ACTIVE
	
	damage_effect.execute(target_array)

	await wait_anim(sprite, "attack2")
	if is_interrupted: return interrupt()

	# ========================
	# 收尾
	# ========================
	state = AttackState.RECOVERY
	sprite.play("idle")
	await wait_anim(sprite, "idle")

	await move_to(start)

	state = AttackState.IDLE
	Events.enemy_action_completed.emit(enemy)

func interrupt():
	state = AttackState.INTERRUPTED
	
	var sprite: AnimatedSprite2D = enemy.animated_sprite_2d
	sprite.stop()
	sprite.play("hit")  # 被弹反动画
	
	# 可加击退 / 硬直
	await wait_anim(sprite, "hit")
	
	Events.enemy_action_completed.emit(enemy)
