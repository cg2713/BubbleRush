extends Node
class_name LapCounter

var lap: int = 0

func lap_counted(value: int):
	lap += value
