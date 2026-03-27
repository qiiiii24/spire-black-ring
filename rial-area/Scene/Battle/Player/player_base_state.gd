extends PlayerState

func enter() -> void:
	player.animated_sprite_2d.play("idle")

func process(_delta: float) -> void:
	player.add_mana(_delta)
