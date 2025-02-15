extends PlayerBehavior
class_name Gravity

@export var gravity := Vector3(0, 9.8, 0)

func physics(delta: float):
	if player.is_on_floor():
		return
	
	player.velocity -= gravity * delta
