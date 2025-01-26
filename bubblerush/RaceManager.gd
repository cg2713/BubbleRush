extends Node3D

@export var racers = []
@export var RaceStarted = false
@export var Checkpoints = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Function called when race begins
func _on_hud_race_start() -> void:
	print("Race Started!!!")
	RaceStarted = true
	pass # Replace with function body.
