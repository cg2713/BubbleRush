extends Control

#@export var stopwatch : Stopwatch
var counter : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _draw():
	if counter > 1:
		draw_circle(Vector2(size.x/3,size.y/5),50,Color.RED)
	if counter > 2:
		draw_circle(Vector2(size.x/2,size.y/5),50,Color.YELLOW)
	if counter > 3:
		draw_circle(Vector2(size.x/3 * 2,size.y/5),50,Color.GREEN)


func _on_timer_timeout() -> void:
	counter += 1
	if counter > 4:
		get_parent().stopwatch.start()
		#stopwatch.start()
		queue_free()
	queue_redraw()
	pass # Replace with function body.
