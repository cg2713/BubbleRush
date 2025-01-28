extends Control

@export var playerNode : Node
@export var playerControlerResource : Array[Resource]
var playersReady : Array[Node]
var playersReadyBool : Array[bool]


func _ready() -> void:
	playersReady.append(playerNode.get_child(0).get_child(0))
	# this scene is duplicating a node template taht consist of a 3d node with a scene that rotates 
	# the current models in the game
	# if the game only has one player then we dont need to duplicate the player and split the screen
	if Game.playercount != 1:
		# in this scope this is where the screen get splits depending on how many players ther are
		playerNode.get_child(0).size.x = $VBoxContainer.size.x/Game.playercount
		playerNode.get_child(0).size.y = size.y
		for i in range(Game.playercount - 1):
			var newNode : Node = playerNode.duplicate()
			newNode.get_child(0).size.x = $VBoxContainer.size.x / Game.playercount
			newNode.get_child(0).size.y = size.y
			playersReady.append(newNode.get_child(0).get_child(0))
			newNode.get_child(0).get_child(0).control = playerControlerResource[i+1]
			$VBoxContainer/GridContainer.add_child(newNode)
	else:
		playerNode.get_child(0).size.x = $VBoxContainer.size.x
		playerNode.get_child(0).size.y = size.y
	pass
	

func set_player_choices():
	for i in range(len(playersReady)):
		Game.playerChoices[i] = playersReady[i].values
	print("Player choices = ", Game.playerChoices)
		#print(i.values)
	get_tree().change_scene_to_file("res://Level_preview.tscn")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# in here we are just checking if all the players are ready
	playersReadyBool = []
	for i in playersReady:
		playersReadyBool.append(i.finished)
	#print(playersReadyBool)
	# if all players are ready then we will change it to the next scene
	if not false in playersReadyBool:
		set_player_choices()
		
		# move to next scene
	pass
