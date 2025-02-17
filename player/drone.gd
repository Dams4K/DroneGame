extends CharacterBody3D

@export var Y_SPEED: float = 10
@export var MOVE_SPEED: float = 20
@export var ROTATE_SPEED: float = 3

@export_category("X Rotation")
@export var rotation_curve: Curve

@export var CAMERA_MAX_ROTATION_X = 0.15
@export var CAMERA_MAX_ROTATION_Z = 0.05

@export var CAMERA_ROTATION_X_SPEED = 2.0
@export var CAMERA_ROTATION_X_RESET_SPEED = 0.7

@export_category("Y Rotation")
@export var ROTATION_MAX_SPEED := 5.0
@export var ROTATION_SPEED_CURVE: Curve

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
	
	var rotate_speed = ROTATION_MAX_SPEED * ROTATION_SPEED_CURVE.sample(abs(y_rotation)/2)
	rotation.y += sign(y_rotation) * rotate_speed * delta
	
	if abs(y_move) != 0:
		var max_rotation = rotation_curve.sample(abs(y_move))
		camera_3d.rotation.x = move_toward(camera_3d.rotation.x, inverted * sign(y_move) * max_rotation, delta * CAMERA_ROTATION_X_SPEED)
	else:
		camera_3d.rotation.x = move_toward(camera_3d.rotation.x, 0.0, delta * CAMERA_ROTATION_X_RESET_SPEED)
	camera_3d.rotation.z = clamp(y_rotation * delta, -CAMERA_MAX_ROTATION_Z, CAMERA_MAX_ROTATION_Z)
	
	move_and_slide()
	
	var nb_collision = get_slide_collision_count()
	if nb_collision > 0 and Input.get_connected_joypads().size() > 0:
		Input.vibrate_handheld(100)
