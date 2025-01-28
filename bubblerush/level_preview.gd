extends Node3D
@export_range(0,3) var values = 0
@export var models : Array[Node]
# this is a reasorce node so taht we can drag and drop player controls withough redefining so much
@export var control : Resource = null
var finished : bool = false
@export var Levels : Array[PackedScene]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	models[values].visible = true
	pass # Replace with function body.

# the player can choose waht car they would like with there controls
func _process(delta: float) -> void:
	models[values].visible = true
	if Input.is_action_just_pressed(control.move_right):
		models[values].visible = false
		values -= 1
		values %= len(models)
		models[values].visible = true
	if Input.is_action_just_pressed(control.move_left):
		models[values].visible = false
		values -= 1
		values = (values + len(models)) % len(models)
		models[values].visible = true
	# confirms the selection of the level for all players 1st player will control this scene
	if Input.is_action_just_pressed(control.move_back):
		get_tree().change_scene_to_packed(Levels[values])
		pass
		
	#if finished:
		#$SpotLight3D.light_color = Color.GREEN
	#else:
		#$SpotLight3D.light_color = Color.WHITE
		
		
	models[values].rotation.y += 1 * delta
	pass
