extends Panel
class_name BattleOverPanel

enum Type {WIN, LOSE}

@onready var label: Label = %Label
@onready var continue_button: Button = %ContinueButton
@onready var restart_button: Button = %RestartButton

func _ready() -> void:
	continue_button.pressed.connect(battle_settlement)
	restart_button.pressed.connect(get_tree().reload_current_scene)
	Events.battle_over_screen_requested.connect(show_screen)

func show_screen(text: String, type: Type) -> void:
	label.text = text
	continue_button.visible = type == Type.WIN
	restart_button.visible = type == Type.LOSE
	show()

func battle_settlement() -> void:
	var battle_scene = get_tree().get_first_node_in_group("battle")
	battle_scene.queue_free()
