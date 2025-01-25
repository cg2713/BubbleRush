extends Node
class_name Stopwatch

var time = 0.0
var stoppped = true

func _process(delta):
	if not stoppped:
		time += delta
	
func start():
	stoppped = false
	
func reset():
	time = 0.0

func time_to_string() -> String:
	var msec = fmod(time, 1) * 1000
	var sec = fmod(time, 60)
	var min = time / 60
	var format_string = "%02d : %02d : %02d"
	var actual_string = format_string % [min, sec, msec]
	return actual_string
	
