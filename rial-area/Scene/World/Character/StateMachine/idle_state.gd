extends CharState

func enter() -> void:
	charcter.animated_sprite_2d.play("idle")

func process(_delta: float) -> void:
	if charcter.direction != Vector2.ZERO:
		transition_requested.emit(self,State.WALK)
