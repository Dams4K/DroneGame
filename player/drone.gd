extends CharacterBody3D

@export var Y_SPEED: float = 10
@export var MOVE_SPEED: float = 20
@export var ROTATE_SPEED: float = 3

@export var CAMERA_MAX_ROTATION_X = 0.15
@export var CAMERA_MAX_ROTATION_Z = 0.05

@onready var drone_controls: Node = $DroneControls

@onready var camera_3d: Camera3D = $Camera3D

var inverted = -1

func _physics_process(delta: float) -> void:
	var left_axis: float = drone_controls.get_left_axis()
	var right_axis: float = drone_controls.get_right_axis()
	
	var y_move = left_axis + right_axis
	var y_rotation = left_axis - right_axis
	
	var move_dir = transform.basis * Vector3(0, 0, -1 * MOVE_SPEED)
	velocity.x = move_dir.x
	velocity.z = move_dir.z
	velocity.y = inverted * y_move * Y_SPEED
	rotation.y += y_rotation * ROTATE_SPEED * delta
	
	camera_3d.rotation.x = clamp(camera_3d.rotation.x + inverted * y_move * delta, -CAMERA_MAX_ROTATION_X, CAMERA_MAX_ROTATION_X)
	camera_3d.rotation.z = clamp(y_rotation * delta, -CAMERA_MAX_ROTATION_Z, CAMERA_MAX_ROTATION_Z)
	
	move_and_slide()
