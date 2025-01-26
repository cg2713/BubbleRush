extends Node3D
@export_range(0,3) var values = 0
@export var models : Array[MeshInstance3D]
@export var control : Resource = null
var finished : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	models[values].visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	models[values].visible = true
	if Input.is_action_just_pressed(control.move_right):
		if values + 1 < 4:
			models[values].visible = false
			values += 1
			models[values].visible = true
		else:
			models[values].visible = false
			values = 0
			models[values].visible = true
			
		pass
	if Input.is_action_just_pressed(control.move_left):
		if values - 1 > 0:
			models[values].visible = false
			values -= 1
			models[values].visible = true
		else:
			models[values].visible = false
			values = 3
			models[values].visible = true
			
		pass
	if Input.is_action_just_pressed(control.move_forward):
		finished = false
	if Input.is_action_just_pressed(control.move_back):
		finished = true
	if finished:
		$SpotLight3D.light_color = Color.GREEN
	else:
		$SpotLight3D.light_color = Color.WHITE
		
		
	models[values].rotation.y += 1 * delta
	pass
