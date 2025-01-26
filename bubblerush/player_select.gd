extends Control

#var nextScene : PackedScene = load("res://charater_select.tscn")
var next : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $MarginContainer/GridContainer/Button.button_pressed:
		Game.playercount = 1
		next = true
	if $MarginContainer/GridContainer/Button2.button_pressed:
		Game.playercount = 2
		next = true
	if $MarginContainer/GridContainer/Button3.button_pressed:
		Game.playercount = 3
		next = true
	if $MarginContainer/GridContainer/Button4.button_pressed:
		Game.playercount = 4
		next = true
	if next:
		get_tree().change_scene_to_packed(load("res://charater_select.tscn"))
	#print(Game.playercount)
	pass
