extends Control

const KNIGHT = preload("uid://dp4apcv68hpcq")
const TEST_CHARACTER_2 = preload("uid://bsi0cpoe7qs2u")
const TEST_CHARACTER = preload("uid://da81qjdgifymo")


@onready var character_name: Label = $VBoxContainer/CharacterName
@onready var character_portrait: TextureRect = %CharacterPortrait

var current_character : CharacterStats : set = set_current_character

func set_current_character(new_character: CharacterStats) -> void:
	current_character = new_character
	character_name.text = current_character.character_name
	character_portrait.texture = current_character.portrait
	

func _on_start_button_pressed() -> void:
	print("使用%s进行游戏" % current_character.character_name)


func _on_character_button_pressed() -> void:
	current_character = KNIGHT


func _on_character_button_2_pressed() -> void:
	current_character = TEST_CHARACTER_2


func _on_character_button_3_pressed() -> void:
	current_character = TEST_CHARACTER
