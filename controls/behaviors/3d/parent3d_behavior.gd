extends Behavior
class_name Parent3DBehavior

var parent: Node3D

func _ready() -> void:
	await owner.ready
	parent = owner as Node3D
	assert(parent != null, "Owner must be a 'Node3D'")
