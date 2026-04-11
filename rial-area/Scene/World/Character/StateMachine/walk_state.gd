extends CharState

@export var move_speed := 100.0

func enter() -> void:
	charcter.animated_sprite_2d.play("walk")

func process(_delta: float) -> void:
	if charcter.direction == Vector2.ZERO:
		transition_requested.emit(self, State.IDLE)
		
	charcter.velocity = charcter.direction * move_speed
	
	charcter.update_facing()
	charcter.update_visual()
