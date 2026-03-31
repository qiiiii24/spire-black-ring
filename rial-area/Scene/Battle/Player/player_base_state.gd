extends PlayerState

func enter() -> void:
	player.animated_sprite_2d.play("idle")
	
	#if not Events.card_aim_started.is_connected(update_state):
		#Events.card_aim_started.connect(update_state)
	#
	#if not Events.card_drag_started.is_connected(update_state):
		#Events.card_drag_started.connect(update_state)
	
	if not Events.card_release.is_connected(update_state):
		Events.card_release.connect(update_state)
	

func process(_delta: float) -> void:
	player.add_mana(_delta)

func update_state() -> void:
	transition_requested.emit(self, PlayerState.State.ACTION)
	
