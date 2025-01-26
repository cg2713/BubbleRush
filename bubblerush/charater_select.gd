extends Control

@export var playerNode : Node
@export var playerControlerResource : Array[Resource]
var playersReady : Array[Node]
var playersReadyBool : Array[bool]
#@export var readyGridNode : Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var newcolorRect = ColorRect.new()
	#newcolorRect.color = Color.RED
	playersReady.append(playerNode.get_child(0).get_child(0))
	if Game.playercount != 1:
		playerNode.get_child(0).size.x = $VBoxContainer.size.x/Game.playercount
		playerNode.get_child(0).size.y = $VBoxContainer/GridContainer.size.y
		#newcolorRect.size.x = $VBoxContainer.size.x/Game.playercount
		#newcolorRect.size.y = $VBoxContainer/GridContainer2.size.y
		#readyGridNode.add_child(newcolorRect)
		for i in range(Game.playercount - 1):
			#var newcolorRect2 = ColorRect.new()
			#newcolorRect2.color = Color.RED
			#newcolorRect2.size.x = $VBoxContainer.size.x/Game.playercount
			#newcolorRect2.size.y = $VBoxContainer/GridContainer2.size.y
			var newNode : Node = playerNode.duplicate()
			newNode.get_child(0).size.x = $VBoxContainer.size.x / Game.playercount
			newNode.get_child(0).size.y = $VBoxContainer/GridContainer.size.y
			playersReady.append(newNode.get_child(0).get_child(0))
			newNode.get_child(0).get_child(0).control = playerControlerResource[i+1]
			#readyGridNode.add_child(newcolorRect2)
			$VBoxContainer/GridContainer.add_child(newNode)
	else:
		playerNode.get_child(0).size.x = $VBoxContainer.size.x
		playerNode.get_child(0).size.y = $VBoxContainer/GridContainer.size.y
		#newcolorRect.size.x = $VBoxContainer.size.x/Game.playercount
		#newcolorRect.size.y = $VBoxContainer/GridContainer2.size.y
		#readyGridNode.add_child(newcolorRect)
	pass
	

func set_player_choices():
	for i in playersReady:
		print(i.values)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	playersReadyBool = []
	for i in playersReady:
		playersReadyBool.append(i.finished)
	#print(playersReadyBool)
	if not false in playersReadyBool:
		set_player_choices()
		print("checked")
		# move to next scene
	pass
