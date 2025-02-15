@tool
extends PlayerBehavior
class_name Move

@export var ACCELERATION := 100.0
@export var MAX_SPEED := 5.0
@export var FRICTION := 100.0

var forward: StringName
var back: StringName
var left: StringName
var right: StringName

func physics(delta: float):
	var input = Input.get_vector(left, right, forward, back)
	var movement_dir = player.transform.basis * Vector3(input.x, 0, input.y)
	if movement_dir:
		player.velocity.x = move_toward(player.velocity.x, movement_dir.x * MAX_SPEED, delta * ACCELERATION)
		player.velocity.z = move_toward(player.velocity.z, movement_dir.z * MAX_SPEED, delta * ACCELERATION)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, FRICTION * delta)
		player.velocity.z = move_toward(player.velocity.z, 0, FRICTION * delta)

func _get_property_list() -> Array[Dictionary]:
	var actions := OnInput.get_actions()
	
	var get_dict = func(a: String) ->  Dictionary: return {
		"name": a,
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(actions)
	}
	
	var properties: Array[Dictionary] = [
		get_dict.call("forward"),
		get_dict.call("back"),
		get_dict.call("left"),
		get_dict.call("right"),
	]
	
	return properties
