extends CharacterBody3D
class_name car


const SPEED = 5.0


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
	velocity.z *= 1 - delta
	#print(velocity.z)
	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	print("area entered")
	print(area)


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("body entered")
	print(body)
