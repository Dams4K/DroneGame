extends PlayerBehavior
class_name Jump

@export var JUMP_SPEED := 20.0

func run():
	if not player.is_on_floor():
		return
	player.velocity.y = JUMP_SPEED
