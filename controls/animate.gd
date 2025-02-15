@tool
extends Behavior
class_name Animate

@export var animation_player: AnimationPlayer : set = set_animation_player
var animation: String = ""

func run():
	super.run()
	if animation_player == null:
		push_error("'animation_player' is null")
		return
	if not animation_player.has_animation(animation):
		push_error("the animation '%s' does not exist")
		return
	animation_player.play(animation)

func set_animation_player(value: AnimationPlayer):
	animation_player = value
	notify_property_list_changed()

func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	
	if animation_player != null:
		var animations := animation_player.get_animation_list()
		
		properties.append({
			"name": "animation",
			"type": TYPE_STRING,
			"hint": PROPERTY_HINT_ENUM,
			"hint_string": ",".join(animations)
		})
	
	return properties
