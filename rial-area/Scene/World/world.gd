extends Node2D

const BATTLE = preload("uid://cw2bqi2hyo0r7")

@onready var current_view: Node = $CurrentView

func _ready() -> void:
	Events.start_battle.connect(start_battle, CONNECT_DEFERRED)

func start_battle() -> void:
	var battle = BATTLE.instantiate()
	
	get_tree().current_scene.add_child(battle)

func _change_view(scene: PackedScene) -> void:
	if current_view.get_child_count() > 0:
		current_view.get_child(0).queue_free()
	
	# 暂停
	#get_tree().paused = false
	var new_view := scene.instantiate()
	current_view.add_child(new_view) 

func _setup_event_connections() -> void:
	pass
