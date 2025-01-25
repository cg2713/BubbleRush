extends CharacterBody3D
class_name car


const SPEED = 25.0

var speed_percent = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#print(input_dir.y)
	var currentVelocity = velocity.length()
	rotate_y(-input_dir.x * delta * currentVelocity/4)
	velocity += transform.basis.z * input_dir.y * SPEED * speed_percent * delta
	velocity += transform.basis.x * input_dir.x * (SPEED/3) * delta * (currentVelocity/4)
	velocity *= 1 - delta * 1.2
	#print(velocity.z)
	move_and_slide()
	
	speed_percent += 0.01
	speed_percent = min(speed_percent, 1)
	print("speed_percent ", speed_percent)


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("area entered")
	print(area)
	if area.name == "DirtArea3D":
		area.get_parent().get_parent().visible = false
		speed_percent *= 0.95
		
