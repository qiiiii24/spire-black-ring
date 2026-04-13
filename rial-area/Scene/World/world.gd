extends Node2D

const BATTLE = preload("uid://cw2bqi2hyo0r7")

func _ready() -> void:
	Events.start_battle.connect(start_battle, CONNECT_DEFERRED)

func start_battle() -> void:
	var battle = BATTLE.instantiate()
	
	get_tree().current_scene.add_child(battle)
