extends HBoxContainer

@onready var left_side: Control = $LeftSide
@onready var right_side: Control = $RightSide

func get_left_axis() -> float:
	return left_side.get_percentage()
	
func get_right_axis() -> float:
	return right_side.get_percentage()
