extends Node

var total_lap: int = 0

func lap_counted(value: int):
	total_lap += value
	LapEvents.emit_signal("lap_counted", total_lap)

#func _finished():
	#if total_lap >= 3:
		#get_tree().quit()
