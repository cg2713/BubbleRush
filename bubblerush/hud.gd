extends Control
class_name HUD

@export var stopwatch_label : Label
@export var LapCounter = Label
signal raceStart()

var stopwatch : Stopwatch

func _ready():
	stopwatch = get_tree().get_first_node_in_group("stopwatch")
	LapEvents.connect("lap_counted", on_event_lap_counted)
	
func on_event_lap_counted(value: int) -> void:
	LapCounter.text = str(value)
	if value >= 3:
		get_tree().quit()

func _process(delta):
	update_stopwatch_label()
	
func raceStarting():
	raceStart.emit()

func update_stopwatch_label():
	stopwatch_label.text = stopwatch.time_to_string()
