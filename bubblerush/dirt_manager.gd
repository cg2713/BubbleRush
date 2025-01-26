extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(reduce_children_transparency)
	timer.one_shot = false
	timer.wait_time = 0.2
	timer.start()

func reduce_children_transparency():
	for child in get_children():
		if child is Node3D:
			var t = child.get_node("MeshInstance3D").transparency
			t -= 0.01
			child.get_node("MeshInstance3D").transparency = max(t, 0)
