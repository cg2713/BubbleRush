extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().current_scene.Checkpoints.append(self)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	#print(body)
	if body is car:
		if not self in body.passedCheckpoints:
			body.checkpoint = position
			body.checkpointRotation = rotation
			body.passedCheckpoints.append(self)
			print("Checkpoint reached:", position)
