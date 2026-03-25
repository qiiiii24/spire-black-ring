extends EnemyState

func enter() -> void:
	if not is_node_ready():
		await ready
	
	enemy.animated_sprite_2d.play("idle")
