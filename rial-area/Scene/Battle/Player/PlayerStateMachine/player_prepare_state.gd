extends PlayerState
## 没有用的状态

func enter() -> void:
	player.animated_sprite_2d.play("prepare")



func update_state(_card_ui: CardUI) -> void:
	transition_requested.emit(self, PlayerState.State.PREPARE)
