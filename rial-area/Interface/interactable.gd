extends Area2D
class_name Interactable

func _init() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

##交互
func interact(character: Character) -> void:
	pass
	
##退出交互
func exit_interact(character: Character) -> void:
	pass

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent() is Character:
		var character: Character = area.get_parent() 
		character.show_interacter(true)
		character.current_interactable = self

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent() is Character:
		var character: Character = area.get_parent() 
		character.show_interacter(false)
		character.current_interactable = null
