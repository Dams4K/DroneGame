@tool
extends Behavior
class_name OnInput

enum InputType {
	IS_PRESSED,
	JUST_PRESSED,
	JUST_RELEASED,
}

@export var input_type: InputType = InputType.JUST_PRESSED

var action: StringName

func _process(_delta: float):
	if Engine.is_editor_hint():
		return
	
	var is_pressed: bool = input_type == InputType.IS_PRESSED and Input.is_action_pressed(action)
	var just_pressed: bool = input_type == InputType.JUST_PRESSED and Input.is_action_just_pressed(action)
	var just_released: bool = input_type == InputType.JUST_RELEASED and Input.is_action_just_released(action)
	if is_pressed or just_pressed or just_released:
		run_child()

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	var actions := get_actions()
	
	properties.append({
		"name": "action",
		"type": TYPE_STRING_NAME,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": ",".join(actions)
	})
	
	return properties

static func get_actions() -> Array[StringName]:
	var actions: Array[StringName] = []
	for prop: Dictionary in ProjectSettings.get_property_list():
		var prop_name: StringName = prop.get("name", "")
		if not prop_name.begins_with("input/"):
			continue
		var eaction: StringName = prop_name.replace("input/", "").substr(0, prop_name.find("."))
		if actions.has(eaction):
			continue
		
		actions.append(eaction)
		
	actions.reverse() # built-in inputs will be at the end of the list
	return actions
