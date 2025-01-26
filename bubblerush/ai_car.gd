extends car

@export var waypoint_path : Path3D
@export var look_ahead_distance = 4

var current_waypoint : int = 0

func get_input_dir():
	print("curr ", current_waypoint)
	var target_waypoint : Vector3 = waypoint_path.curve.get_point_position(current_waypoint)
	
	# Find the direction to the waypoint in the car's local space
	var local_target_direction = global_transform.basis.inverse() * (target_waypoint - global_transform.origin).normalized()

	#print("dir ", local_target_direction)
	#print("distance ", (target_waypoint - global_transform.origin).length())

	# Are we there yet?
	if (target_waypoint - global_transform.origin).length() < look_ahead_distance:
		# Target the next waypoint
		current_waypoint = (current_waypoint + 1) % waypoint_path.curve.point_count

	$debugMarkerSteer.position = local_target_direction * 2 # Visual debug in local space
	$debugMarkerObjective.global_position = target_waypoint

	# Calculate the steering input based on the local direction:
	var steer_input = local_target_direction.x # Positive if target is to the right, negative if to the left
	
	steer_input = clamp(steer_input, -1.0, 1.0)

	var speed_input = -1

	return Vector2(steer_input, speed_input)
