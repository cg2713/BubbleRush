extends CharacterBody3D
class_name car

@export var LapsCompleted = 0
const SPEED = 25.0
@export var base_FOV = 75
@export var speedup_FOV = 120
@export var player2 = false
@export var PlayerChoice = 1
@export var checkpoint: Vector3
@export var checkpointRotation: Vector3
@export var carCam: Camera3D

# AI variables
@export var ai_waypoint_path : Path3D # if set, this is an AI car
const ai_look_ahead_distance = 4
var ai_current_waypoint : int = 0
var ai_objective : Vector3

var speed_percent = 1
var input_dir: Vector2

func _ready() -> void:
	carCam.top_level = true
	
	# Hide all except chosen
	for child in $"3DModel".get_children():
		child.visible = false
	$"3DModel".get_children()[PlayerChoice - 1].visible = true
	
	checkpoint = position

func _process(delta: float) -> void:
	if position.y <= -10:
		position = checkpoint
		rotation = checkpointRotation
		velocity = Vector3.ZERO
		
func _complete_lap():
	# Include check to confirm that car has traveled around the map
	LapsCompleted += 1
	if LapsCompleted >= 3:
		# This car wins!
		get_tree().quit()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	carCam.global_transform = carCam.global_transform.interpolate_with(%CameraHolder.global_transform, 10 * delta)
	#%Camera3D.transform=%CameraHolder.transform
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if get_tree().current_scene.RaceStarted:
		input_dir = get_ai_input_dir() if is_ai_car() else get_input_dir()
	#print(input_dir.y)
	var currentVelocity = velocity.length()
	rotate_y(-input_dir.x * delta * currentVelocity / 4)
	velocity += transform.basis.z * input_dir.y * SPEED * speed_percent * delta
	velocity += transform.basis.x * input_dir.x * (SPEED / 3) * delta * (currentVelocity / 4)
	velocity *= 1 - delta * 1.2
	#print(velocity.z)
	move_and_slide()
	
	speed_percent += 0.01
	speed_percent = min(speed_percent, 1)
	#print("speed_percent ", speed_percent)

	#if currentVelocity > 0.0 and %Camera3D.fov <= speedup_FOV:
	#	%Camera3D.fov = %Camera3D.fov * (1 - delta) + speedup_FOV * delta
	#elif %Camera3D.fov >= base_FOV:
	#	%Camera3D.fov = %Camera3D.fov * (1 - delta) + base_FOV * delta
	carCam.fov = base_FOV + currentVelocity * 3
	
	#print("velocity ", velocity.length())
	if is_on_floor():
		$BubbleTrail/BubbleParticles3D.amount_ratio = velocity.length() / 10
		$BubbleTrail/FoamParticles3D.amount_ratio = velocity.length() / 10
	else:
		$BubbleTrail/BubbleParticles3D.amount_ratio = $BubbleTrail/BubbleParticles3D.amount_ratio + (0 - $BubbleTrail/BubbleParticles3D.amount_ratio) * delta * 10
		$BubbleTrail/FoamParticles3D.amount_ratio = $BubbleTrail/FoamParticles3D.amount_ratio + (0 - $BubbleTrail/FoamParticles3D.amount_ratio) * delta * 10
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	#print("area entered")
	#print(area)
	if area.name == "DirtArea3D":
		#area.get_parent().get_parent().visible = false
		var dirt_mesh_instance: MeshInstance3D = area.get_parent()
		var current_dirt_energy = 1 - dirt_mesh_instance.transparency # Goes from 0 lowest, to 1
		# When energy is the highest, the speed percent is going to be reduced by 5%
		# When energy is the lowest (0), speed is not changing
		speed_percent *= lerp(1.0, 0.95, current_dirt_energy)
		# print(speed_percent)
		dirt_mesh_instance.transparency += 0.9
		#print("dirt_mesh_instance.transparency ", dirt_mesh_instance.transparency)
		
func get_input_dir():
	if not player2:
		return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	else:
		return Input.get_vector("left", "right", "forward", "back")
		
func get_ai_input_dir():
	#print("curr ", current_waypoint)
	if ai_objective == Vector3.ZERO:
		ai_objective = ai_waypoint_path.curve.get_point_position(ai_current_waypoint)
		# Randomize objective a little bit so that different AI cars dont clutter
		const randomness = 2
		ai_objective.x += randf_range(-randomness,randomness)
		ai_objective.z += randf_range(-randomness,randomness)
	
	# Find the direction to the waypoint in the car's local space
	var local_target_direction = global_transform.basis.inverse() * (ai_objective - global_transform.origin).normalized()

	#print("dir ", local_target_direction)

	# Are we there yet?
	var current_distance = (ai_objective - global_transform.origin).length()
	#print("distance ", current_distance)
	if current_distance < ai_look_ahead_distance:
		# Target the next waypoint
		ai_current_waypoint = (ai_current_waypoint + 1) % ai_waypoint_path.curve.point_count
		ai_objective = Vector3.ZERO
		
	if find_child("debugMarkerObjective") != null:
		$debugMarkerObjective.global_position = ai_objective

	#$debugMarkerSteer.position = local_target_direction * 2 # Visual debug in local space
	

	# Calculate the steering input based on the local direction:
	var steer_input = local_target_direction.x # Positive if target is to the right, negative if to the left
	
	steer_input = clamp(steer_input, -1.0, 1.0)

	var speed_input = -1

	return Vector2(steer_input, speed_input)

func is_ai_car() -> bool:
	return ai_waypoint_path != null
