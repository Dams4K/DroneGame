extends Control

const MAP_BUTTON = preload("res://map_button.tscn")

@export var levels: Array[PackedScene] = []

@onready var grid_container: GridContainer = $GridContainer

func _ready() -> void:
	generate_maps_buttons()

func generate_maps_buttons():
	for level: PackedScene in levels:
		var btn: Button = MAP_BUTTON.instantiate()
		var level_name = level.resource_path.split("/")[-1]
		btn.text = level_name
		btn.connect("pressed", join_level.bind(level))
		grid_container.add_child(btn)

func join_level(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)
