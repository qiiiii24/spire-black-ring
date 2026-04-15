extends Control

const CHARACTER_SELECTOR = preload("uid://cbc6s3lxaoio2")

@onready var continue_button: Button = %Continue

func _ready() -> void:
	get_tree().paused = false

func _on_continue_pressed() -> void:
	print("继续游戏")


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_packed(CHARACTER_SELECTOR)


func _on_exit_pressed() -> void:
	get_tree().quit()
