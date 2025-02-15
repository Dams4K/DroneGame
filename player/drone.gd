extends CharacterBody3D

@export var Y_SPEED: float = 10
@export var MOVE_SPEED: float = 20
@export var ROTATE_SPEED: float = 3

@export var CAMERA_MAX_ROTATION_X = 0.15
@export var CAMERA_MAX_ROTATION_Z = 0.05

@export var CAMERA_ROTATION_X_SPEED = 2.0
@export var CAMERA_ROTATION_X_RESET_SPEED = 0.7

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
	
	if abs(y_move) <= 1:
		camera_3d.rotation.x = move_toward(camera_3d.rotation.x, inverted * sign(y_move) * CAMERA_MAX_ROTATION_X / 4, delta * CAMERA_ROTATION_X_SPEED / 4)
	elif abs(y_move) > 1:
		#camera_3d.rotation.x = clamp(camera_3d.rotation.x + inverted * y_move * delta, -CAMERA_MAX_ROTATION_X, CAMERA_MAX_ROTATION_X)
		camera_3d.rotation.x = move_toward(camera_3d.rotation.x, inverted * sign(y_move) * CAMERA_MAX_ROTATION_X, delta * CAMERA_ROTATION_X_SPEED)
	else:
		camera_3d.rotation.x = move_toward(camera_3d.rotation.x, 0.0, delta * CAMERA_ROTATION_X_RESET_SPEED)
	camera_3d.rotation.z = clamp(y_rotation * delta, -CAMERA_MAX_ROTATION_Z, CAMERA_MAX_ROTATION_Z)
	
	move_and_slide()
	
	var nb_collision = get_slide_collision_count()
	if nb_collision > 0 and Input.get_connected_joypads().size() > 0:
		Input.vibrate_handheld(100)
