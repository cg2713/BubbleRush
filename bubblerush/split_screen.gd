extends Node3D

@export var playerNode : Node
@export_range(1,4) var amountOfPlayers = Game.playercount
var cameraList : Array[Camera3D]
@export var carList : Array[car]
@export var AICarList : Array[car]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# duplicating a node tempalte so if we only have 1 player then we dont need to duplicate
	if Game.playercount != 1:
		#this will divide the screen based on how many players there are if there are 3 then it will divide it 3 ways
		if Game.playercount <= 3:
			playerNode.get_child(0).size.x = $MarginContainer.size.x/Game.playercount
			playerNode.get_child(0).size.y = $MarginContainer.size.y
			$MarginContainer/GridContainer.columns = Game.playercount
		else: # but when there are 4 palyers then the grid will get an extra culum to divide it more evenly and have a better screen ratio
			playerNode.get_child(0).size.x = $MarginContainer.size.x/2
			playerNode.get_child(0).size.y = $MarginContainer.size.y/2
			$MarginContainer/GridContainer.columns = 2
		# since we there was not enogh information about linking cameras this will genrate new cameras and 
		# swap them out for the cars so the cars will lose their original cameras
		cameraList.append(playerNode.get_child(0).get_child(0))
		carList[0].lapCounterUI = playerNode.get_child(0).get_child(0).get_child(0).get_child(0)
			
		print($MarginContainer/GridContainer.columns)
		# this is where we duplicated depeding on how many players there are in the game
		for i in range(Game.playercount-1):
			var newNode : Node = playerNode.duplicate()
			# 
			carList[i+1].lapCounterUI = newNode.get_child(0).get_child(0).get_child(0).get_child(0)
			if Game.playercount <= 3:
				newNode.get_child(0).size.x = $MarginContainer.size.x/Game.playercount
				newNode.get_child(0).size.y = $MarginContainer.size.y
				
			else:
				newNode.get_child(0).size.x = $MarginContainer.size.x/2
				newNode.get_child(0).size.y = $MarginContainer.size.y/2
				#print("it should be in here")
			print(newNode.get_child(0).size.x,' ', newNode.get_child(0).size.y)	
			#newNode.get_child(0).add_child(cameraList[i+1])
			$MarginContainer/GridContainer.add_child(newNode)
			cameraList.append(newNode.get_child(0).get_child(0))
	else:
		playerNode.get_child(0).size = $MarginContainer.size
		cameraList.append(playerNode.get_child(0).get_child(0))
		# this is setting up the UI per camera
		carList[0].lapCounterUI = playerNode.get_child(0).get_child(0).get_child(0).get_child(0)
	# this is where the player choice of car get assigned per car per player
	for i in range(Game.playercount):
		carList[i].PlayerChoice = Game.playerChoices[i] + 1
		print("car ", i, "  is ", carList[i].PlayerChoice)
		carList[i].carCam = cameraList[i]
		AICarList[3-i].queue_free()
	# this is where AI cars will be deleted based on how many players are playing so the race will always have 4 palyers
	for i in range(4-Game.playercount):
		carList[3-i].queue_free()
		#print(cameraList[i].get_node("Camera3D"))
		#$MarginContainer/GridContainer.get_child(i).get_child(0).add_child(cameraList[i])     
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
