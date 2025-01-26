extends Node3D
class_name Finish_Line

@export var value: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	#print(body)
	if body is car:
		body.LapsCompleted += 1
	pass # Replace with function body.

#func _finished():
	#if value >= 3:
		#get_tree().quit()
