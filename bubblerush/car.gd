extends CharacterBody3D


const SPEED = 15.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#print(input_dir.y)
	rotate_y(-input_dir.x * delta)
	velocity += transform.basis.z * input_dir.y * SPEED * delta
	velocity += transform.basis.x * input_dir.x * (SPEED/3) * delta
	velocity *= 1 - delta * 1.5
	print(velocity.z)
	move_and_slide()
