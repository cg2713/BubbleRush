extends Node3D
@export_range(0,3) var values = 0
@export var model_parent : Node3D
@export var control : Resource = null
# this node allws the player to cycle though all the models in the game for them to choose what car they woul like to play


var models : Array[Node]
var finished : bool = false
var n : int

func _ready() -> void:
	models = model_parent.get_children()
	n = len(models)
	for model in models:
		model.visible = false
	models[values].visible = true
	pass # Replace with function body.


func _process(delta: float) -> void:
	models[values].visible = true
	# these if staments just check if a player button has been check and to turn on 
	# and off node visibility to act as a selection for the player
	if Input.is_action_just_pressed(control.move_right):
		if values + 1 < len(model_parent.get_children()):
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
			values = len(model_parent.get_children())-1
			models[values].visible = true
			
		pass
	# once a selection has been made then it will change the light source to a green color
	# and also let the char node know that this player has confirmed there choice
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
