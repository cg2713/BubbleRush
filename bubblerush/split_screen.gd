extends Node3D

@export var playerNode : Node
@export_range(1,4) var amountOfPlayers = Game.playercount
var cameraList : Array[Camera3D]
@export var carList : Array[car]
@export var AICarList : Array[car]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if amountOfPlayers != 1:
		
		if amountOfPlayers <= 3:
			playerNode.get_child(0).size.x = $MarginContainer.size.x/amountOfPlayers
			playerNode.get_child(0).size.y = $MarginContainer.size.y
			$MarginContainer/GridContainer.columns = amountOfPlayers
		else:
			playerNode.get_child(0).size.x = $MarginContainer.size.x/2
			playerNode.get_child(0).size.y = $MarginContainer.size.y/2
			$MarginContainer/GridContainer.columns = 2
		cameraList.append(playerNode.get_child(0).get_child(0))
			
		print($MarginContainer/GridContainer.columns)
		for i in range(amountOfPlayers-1):
			var newNode : Node = playerNode.duplicate()
			print("New Node", newNode)
			print("Thingy", newNode.get_child(0).get_child(0).get_child(0).get_child(0))
			carList[i].lapCounterUI = newNode.get_child(0).get_child(0).get_child(0).get_child(0)
			print("Lap Counter", carList[i].lapCounterUI)
			if amountOfPlayers <= 3:
				newNode.get_child(0).size.x = $MarginContainer.size.x/amountOfPlayers
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
	
	for i in range(amountOfPlayers):
		carList[i].carCam = cameraList[i]
		AICarList[3-i].queue_free()
	for i in range(4-amountOfPlayers):
		carList[3-i].queue_free()
		#print(cameraList[i].get_node("Camera3D"))
		#$MarginContainer/GridContainer.get_child(i).get_child(0).add_child(cameraList[i])     
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
