extends car

@export var waypoint_path : Path3D
@export var look_ahead_distance = 4

var current_waypoint : int = 0
var objective : Vector3

# Override
func get_input_dir():
	print("curr ", current_waypoint)
	if objective == Vector3.ZERO:
		var target_waypoint : Vector3 = waypoint_path.curve.get_point_position(current_waypoint)
		objective = target_waypoint
		# Randomize objective a little bit so that different AI cars dont clutter
		const randomness = 4
		objective.x += randf_range(-randomness,randomness)
		objective.z += randf_range(-randomness,randomness)
	
	# Find the direction to the waypoint in the car's local space
	var local_target_direction = global_transform.basis.inverse() * (objective - global_transform.origin).normalized()

	#print("dir ", local_target_direction)

	# Are we there yet?
	var current_distance = (objective - global_transform.origin).length()
	print("distance ", current_distance)
	if current_distance < look_ahead_distance:
		# Target the next waypoint
		current_waypoint = (current_waypoint + 1) % waypoint_path.curve.point_count
		objective = Vector3.ZERO
		
	if find_child("debugMarkerObjective") != null:
		$debugMarkerObjective.global_position = objective

	#$debugMarkerSteer.position = local_target_direction * 2 # Visual debug in local space
	

	# Calculate the steering input based on the local direction:
	var steer_input = local_target_direction.x # Positive if target is to the right, negative if to the left
	
	steer_input = clamp(steer_input, -1.0, 1.0)

	var speed_input = -1

	return Vector2(steer_input, speed_input)
