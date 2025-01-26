extends Node

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
var boolDict : Dictionary = {}
var counter = 0
func _ready() -> void:
	for i in len($".".get_children()):
		boolDict[i] = true
		pass
	print(boolDict)
	pass # Replace with function body.

func grow(bubble : Node, indx : int):
	var tween = create_tween()
	var oldScale = Vector2(bubble.scale.x,bubble.scale.y)
	#var rndomScaleFactor: float = rng.randf_range(2,3)
	tween.tween_property(bubble, "scale", oldScale*rng.randf_range(1,2), rng.randf_range(0.5,2.5))
	tween.tween_property(bubble, "scale", oldScale, rng.randf_range(0.5,2.5))
	tween.tween_callback(resetTween.bind(indx))

func resetTween(indx):
	boolDict[indx] = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter = 0
	for i in $".".get_children():
		if rng.randi_range(0,len($".".get_children())) > len($".".get_children())/4 and boolDict[counter]:
			boolDict[counter] = false
			grow(i,counter)
		counter += 1
	pass
