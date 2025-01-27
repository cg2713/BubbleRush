extends Node3D
class_name Finish_Line

@export var value: int = 1
@export var SFX : Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	#print(body)
	if body is car:
		if len(body.passedCheckpoints) >= len(get_tree().current_scene.Checkpoints):
			body._complete_lap()
			var playback = $AudioStreamPlayer3D.get_stream_playback()
			for sfx in SFX:
				playback.play_stream(sfx, 0, 1, 1, 0, "Master");
	pass # Replace with function body.

#func _finished():
	#if value >= 3:
		#get_tree().quit()
