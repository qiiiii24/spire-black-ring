extends PlayerState

func enter() -> void:
	if not Events.card_played.is_connected(update_anim):
		Events.card_played.connect(update_anim)


func update_anim(card: Card) -> void:
	var type := card.type
	match type:
		Card.Type.ATTACK:
			player.animated_sprite_2d.play("attack")
			
		Card.Type.SKILL:
			player.animated_sprite_2d.play("block")
	
	await player.animated_sprite_2d.animation_finished
	transition_requested.emit(self, PlayerState.State.BASE)
	
