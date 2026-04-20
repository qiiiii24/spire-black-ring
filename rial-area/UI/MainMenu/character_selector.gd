extends Control

const WORLD = preload("uid://besvlki6cqsfu")
const KNIGHT = preload("uid://dp4apcv68hpcq")
const TEST_CHARACTER_2 = preload("uid://bsi0cpoe7qs2u")
const TEST_CHARACTER = preload("uid://da81qjdgifymo")

@export var run_startup: RunStartup

@onready var character_name: Label = $VBoxContainer/CharacterName
@onready var character_portrait: TextureRect = %CharacterPortrait

var current_character : CharacterStats = KNIGHT : set = set_current_character

func set_current_character(new_character: CharacterStats) -> void:
	current_character = new_character
	character_name.text = current_character.character_name
	character_portrait.texture = current_character.portrait
	

func _on_start_button_pressed() -> void:
	run_startup.type = RunStartup.Type.NEW_GAME
	run_startup.picked_character = current_character
	print("使用%s进行游戏" % current_character.character_name)
	get_tree().change_scene_to_packed(WORLD)


func _on_character_button_pressed() -> void:
	current_character = KNIGHT


func _on_character_button_2_pressed() -> void:
	current_character = TEST_CHARACTER_2


func _on_character_button_3_pressed() -> void:
	current_character = TEST_CHARACTER
