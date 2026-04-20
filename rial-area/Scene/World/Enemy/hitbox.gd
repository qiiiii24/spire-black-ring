extends Interactable

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Character:
		var character: Character = area.get_parent() 
		character.current_interactable = self
		Events.call_deferred("emit_signal", "enter_battle")

func _on_area_exited(area: Area2D) -> void:
	pass
