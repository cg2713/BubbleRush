extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "[center]Congration
	playr " + str(Game.Winner+1) + " wins"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
