class_name EnemyHandler
extends Node2D

const ORC = preload("uid://dooyh4bnbvakx")

func add_enemy(enemy:Enemy) -> void:
	var new_enemy := ORC.instantiate()
	new_enemy.position = Vector2(950,416)
	add_child(new_enemy)
