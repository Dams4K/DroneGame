extends Parent3DBehavior
class_name FPSView

@export var sensitivity: float = 3.0
@export var camera: Camera3D

@export var enable_controller := true
@export var controller_sensibility := 2.0

var look_dir: Vector2 # Input direction for aim

func _ready() -> void:
	super()
	assert(camera != null, "Camera can't be null")
	capture_mouse()
	set_process(enable_controller)

func capture_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
func release_mouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _rotate() -> void:
	parent.rotation.y -= look_dir.x * sensitivity
	camera.rotation.x = clamp(camera.rotation.x - look_dir.y * sensitivity, -1.5, 1.5)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.001
		if is_mouse_captured():
			_rotate()

func _process(_delta: float) -> void:
	var vect := Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	if vect != Vector2.ZERO:
		look_dir = 0.01 * vect * controller_sensibility
		_rotate()

#region IS functions
func is_mouse_captured():
	return Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
#endregion
