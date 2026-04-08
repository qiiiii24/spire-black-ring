extends Card

func apply_effects(targets: Array[Node]) -> void:
	var parry_effect := ParryEffect.new()
	#block_effect.sound = sound
	parry_effect.execute(targets)
