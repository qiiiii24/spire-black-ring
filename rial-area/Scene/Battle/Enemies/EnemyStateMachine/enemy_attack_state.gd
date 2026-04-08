extends EnemyState

@export var damage := 4

var tween : Tween
var can_be_parried : bool = false

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
	tween = create_tween().set_trans(Tween.TRANS_QUINT)
	var start := enemy.global_position
	var end := target.global_position + Vector2.RIGHT * 128
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	#damage_effect.sound = sound
	
	#tween.tween_property(enemy, "global_position", end, 0.4)
	
	tween.tween_callback(sprite.play.bind("attack"))
	tween.tween_callback(func(): can_be_parried = true)
	tween.tween_interval(get_anim_time(sprite, "attack"))
	## 可以在这段时间设置弹反窗口
	tween.tween_callback(damage_effect.execute.bind(target_array))
	
	
	tween.tween_callback(sprite.play.bind("attack2"))
	tween.tween_interval(get_anim_time(sprite, "attack2"))
	tween.tween_callback(damage_effect.execute.bind(target_array))
	tween.tween_callback(func(): can_be_parried = false)
	tween.tween_callback(sprite.play.bind("idle"))
	#tween.tween_property(enemy, "global_position", start, 0.4)
	
	tween.finished.connect(
		func():
			transition_requested.emit(self,EnemyState.State.BASE)
			Events.enemy_action_completed.emit(enemy)
			)

func exit() -> void:
	if tween:
		tween.kill()

func process(_delta: float) -> void:
	if can_be_parried:
		if target is Player and target.stats.parry:
			on_parried()


## 被弹反的处理
func on_parried():
	target.stats.parry = false
	can_be_parried = false
	if tween:
		tween.kill()
	tween = create_tween()
	## 播放被弹反的动画
	var sprite : AnimatedSprite2D = enemy.animated_sprite_2d
	tween.tween_callback(sprite.play.bind("hit"))
	tween.tween_interval(get_anim_time(sprite, "hit"))
	tween.finished.connect(
		func():
			transition_requested.emit(self,EnemyState.State.BASE)
			Events.enemy_action_completed.emit(enemy)
			)
