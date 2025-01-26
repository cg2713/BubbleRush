extends Control

@export var playerNode : Node
var cameraList : Array[Camera3D]
@export var carList : Array[Node3D]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Game.playercount != 1:
		playerNode.get_child(0).size.x = $VBoxContainer.size.x/Game.playercount
		playerNode.get_child(0).size.y = $VBoxContainer/GridContainer.size.y
		for i in range(Game.playercount - 1):
			var newNode : Node = playerNode.duplicate()
			newNode.get_child(0).size.x = $VBoxContainer.size.x / Game.playercount
			newNode.get_child(0).size.y = $VBoxContainer/GridContainer.size.y
			$VBoxContainer/GridContainer.add_child(newNode)
	else:
		playerNode.get_child(0).size.x = $VBoxContainer.size.x
		playerNode.get_child(0).size.y = $VBoxContainer/GridContainer.size.y
			
	pass
	
	#if Game.playercount != 1:
		#
		#if Game.playercount <= 3:
			#playerNode.get_child(0).size.x = $MarginContainer.size.x/Game.playercount
			#playerNode.get_child(0).size.y = $MarginContainer.size.y
			#$MarginContainer/GridContainer.columns = Game.playercount
		#else:
			#playerNode.get_child(0).size.x = $MarginContainer.size.x/2
			#playerNode.get_child(0).size.y = $MarginContainer.size.y/2
			#$MarginContainer/GridContainer.columns = 2
		#cameraList.append(playerNode.get_child(0).get_child(0))
			#
		#print($MarginContainer/GridContainer.columns)
		#for i in range(Game.playercount-1):
			#var newNode : Node = playerNode.duplicate()
			#if Game.playercount <= 3:
				#newNode.get_child(0).size.x = $MarginContainer.size.x/Game.playercount
				#newNode.get_child(0).size.y = $MarginContainer.size.y
				#
			#else:
				#newNode.get_child(0).size.x = $MarginContainer.size.x/2
				#newNode.get_child(0).size.y = $MarginContainer.size.y/2
				##print("it should be in here")
			#print(newNode.get_child(0).size.x,' ', newNode.get_child(0).size.y)	
			##newNode.get_child(0).add_child(cameraList[i+1])
			#$MarginContainer/GridContainer.add_child(newNode)
			#cameraList.append(newNode.get_child(0).get_child(0))
	#else:
		#playerNode.get_child(0).size = $MarginContainer.size
		#cameraList.append(playerNode.get_child(0).get_child(0))
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
