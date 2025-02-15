extends Behavior
class_name PlayerBehavior

var player: CharacterBody3D

func _ready() -> void:
	await owner.ready
	player = owner as CharacterBody3D
	assert(player != null, "Owner must be a 'CharacterBody3D'")

func physics(_delta: float):
	pass
