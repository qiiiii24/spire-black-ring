extends Resource
class_name RunStartup

enum Type{NEW_GAME, CONTINUED_GAME}

@export var type: Type 
@export var picked_character: CharacterStats
