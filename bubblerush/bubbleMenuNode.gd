extends Node

# random number genrator to randomise bubble grow effect
var rng = RandomNumberGenerator.new()

# a dictinary to keep track of witch node has been effect by the tween so we dont call it again until its done
var boolDict : Dictionary = {}
var counter = 0
func _ready() -> void:
	for i in len($".".get_children()):
		boolDict[i] = true
		pass
	print(boolDict)
	pass # Replace with function body.

# this is the bubble grow tween function it requres a node and an index
func grow(bubble : Node, indx : int):
	var tween = create_tween()
	var oldScale = Vector2(bubble.scale.x,bubble.scale.y)
	#var rndomScaleFactor: float = rng.randf_range(2,3)
	# cahnge the "Scale" attribute to grow and srink over time
	tween.tween_property(bubble, "scale", oldScale*rng.randf_range(1,2), rng.randf_range(0.5,2.5))
	tween.tween_property(bubble, "scale", oldScale, rng.randf_range(0.5,2.5))
	# once tween has finished t hen we need to reset the index boolean to be called again later
	tween.tween_callback(resetTween.bind(indx))

# this wil reset the boolean in the dict to allow the node to grow again
func resetTween(indx):
	boolDict[indx] = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# and index to keep track of each node for the dict
	counter = 0
	# going though each node in the bubbles to have a chance to grow
	for i in $".".get_children():
		# this will check if the random number is in range 4 frequency and also checks if it can grow
		if rng.randi_range(0,len($".".get_children())) > len($".".get_children())/4 and boolDict[counter]:
			#disables the grow for this node at indx until finished 
			boolDict[counter] = false
			grow(i,counter)
		counter += 1
	pass
