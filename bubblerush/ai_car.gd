extends car

@export var waypoint_path : Path3D
@export var look_ahead_distance = 2

var current_waypoint : int = 0

func get_input_dir():
	print("curr ", current_waypoint)
	var target_waypoint : Vector3 = waypoint_path.curve.get_point_position(current_waypoint)
	
	# Steer? Which direction?
	var steer_direction = (target_waypoint - global_transform.origin).normalized()
	
	print("dir ", steer_direction)
	
	print("distance ", (target_waypoint - global_transform.origin).length())
	
	# Are we there yet?
	if (target_waypoint - global_transform.origin).length() < look_ahead_distance:
		# Target the next waypoint
		current_waypoint = (current_waypoint + 1) % waypoint_path.curve.point_count
	
	return Vector2(steer_direction.x, -steer_direction.y)
