extends Interactable

func interact(character: Character) -> void:
	Events.enter_shop.emit()

func exit_interact(character: Character) -> void:
	Events.exit_interact.emit()
