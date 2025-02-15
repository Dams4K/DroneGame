extends Control

var touch_pos: Vector2
var touching: bool = false

func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		touching = event.pressed
	if event is InputEventScreenDrag:
		touch_pos = event.position
	

func get_percentage():
	if not touching:
		return 0.0
	# values between [-1, 1]
	return clamp((touch_pos.y) / size.y - 0.5, -0.5, 0.5) * 2
