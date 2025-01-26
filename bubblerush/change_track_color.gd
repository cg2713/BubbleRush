extends Node3D

@export var material : Material


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		var instance : MeshInstance3D = child.get_child(0)
		instance.set_surface_override_material(0, material)
