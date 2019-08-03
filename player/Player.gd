extends KinematicBody

const GRAVITY = -60
const FALL_GRAVITY = -130
var actual_gravity = GRAVITY
const ACCELERATION = 6
const DECELERATION = 7
export(int) var speed = 20
export(int) var jump_speed = 40
var velocity = Vector3()
var value = 0.0
var jump_count = 0

onready var camera_rig = find_node("CameraRig")
onready var camera = camera_rig.camera

func _physics_process(delta):
	var direction = Vector3.ZERO
	var camera_transform_basis = camera.global_transform.basis;
	var x = Input.get_action_strength("strafe_right") - Input.get_action_strength("strafe_left")
	var z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	direction += camera_transform_basis.x * x
	direction += camera_transform_basis.z * z
	direction = direction.normalized()
	var nextPosition = direction * speed
	
	if velocity.y > 0:
		actual_gravity = GRAVITY
	else:
		actual_gravity = FALL_GRAVITY
	
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = jump_speed
		jump_count += 1
	else:
		velocity.y += delta * actual_gravity
		if is_on_floor():
			jump_count = 0
	
	var horizontal_velocity = velocity
	horizontal_velocity.y = 0
	
	var accel = ACCELERATION if direction.dot(horizontal_velocity) > 0 else DECELERATION
	horizontal_velocity = lerp(horizontal_velocity, nextPosition, accel * delta)
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if horizontal_velocity != Vector3.ZERO:
		var camera_position = camera_rig.global_transform
		var angle = atan2(horizontal_velocity.x, horizontal_velocity.z) + deg2rad(180)
		var current_rotation = rotation
		current_rotation.y = angle
		rotation = lerp(rotation, current_rotation, value)
		value += delta
		if value > 1:
			value = 1
		camera_rig.global_transform = camera_position