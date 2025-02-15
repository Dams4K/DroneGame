extends Behavior
class_name Attractor3D

@export var object: Node3D
@export var hand: Marker3D
@export var PULL_FORCE := 5.0

@onready var attractor: AttractRigid

func _ready() -> void:
	await owner.ready
	assert(hand != null, "Hand can't be null")
	
	attractor = AttractRigid.new(hand, PULL_FORCE)
	add_child(attractor)

class AttractRigid extends RigidBody3D:
	var _target: Marker3D
	var _pull_force: float
	
	func _init(target: Marker3D, pull_force: float = 1.0) -> void:
		self._target = target
		self._pull_force = pull_force
		custom_integrator = true
	
	func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
		state.linear_velocity = _pull_force*(_target.global_transform.origin-global_transform.origin)

func _process(_delta: float) -> void:
	object.global_transform.origin = attractor.global_transform.origin
