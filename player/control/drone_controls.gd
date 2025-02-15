extends Node

@onready var mobile_layer: CanvasLayer = $MobileLayer
@onready var debug_layer: CanvasLayer = $DebugLayer

@onready var player_mobile_control: HBoxContainer = $MobileLayer/PlayerMobileControl

@onready var left_percentage_label: Label = %LeftPercentageLabel
@onready var right_percentage_label: Label = %RightPercentageLabel

var joypads: Array[int]

var left_axis_lambda: Callable
var right_axis_lambda: Callable

func _ready() -> void:
	debug_layer.visible = OS.has_feature("debug")
	
	var is_on_android = OS.has_feature("android") or OS.has_feature("web_android")
	mobile_layer.visible = is_on_android
	joypads = Input.get_connected_joypads()
	
	if is_on_android:
		left_axis_lambda = func(): return player_mobile_control.get_left_axis()
		right_axis_lambda = func(): return player_mobile_control.get_right_axis()
	elif joypads.size() > 0:
		var joypad_id = joypads[0]
		left_axis_lambda = func(): return format_value(Input.get_joy_axis(joypad_id, JOY_AXIS_LEFT_Y))
		right_axis_lambda = func(): return format_value(Input.get_joy_axis(joypad_id, JOY_AXIS_RIGHT_Y))

func format_value(value: float) -> float:
	if abs(value) < 0.05: return 0
	return value

func get_left_axis() -> float:
	assert(left_axis_lambda != null, "left_axis_lambda is null")
	var value = left_axis_lambda.call()
	assert(value != null, "value for left_axis is null")
	return value
func get_right_axis() -> float:
	assert(right_axis_lambda != null, "right_axis_lambda is null")
	var value = right_axis_lambda.call()
	assert(value != null, "value for right_axis is null")
	return value

func _process(delta: float) -> void:
	left_percentage_label.text = str(get_left_axis())
	right_percentage_label.text = str(get_right_axis())
