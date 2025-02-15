extends Behavior
class_name Camera3DBehavior

var camera: Camera3D

func _ready() -> void:
	await owner.ready
	camera = owner as Camera3D
	assert(camera != null, "Owner must be a 'Camera3D'")
