extends Effect
class_name ParryEffect

func execute(targets: Array[Node]) -> void:
	for target in targets:
		if not target:
			continue
		if target is Player:
			
			target.stats.parry = true
			#SFXPlayer.play(sound)
