extends Spatial

onready var camera = find_node("Camera")
onready var vertical_gimbal = find_node("VerticalGimbal")
onready var horizontal_gimbal = find_node("HorizontalGimbal")
var mouse_rotation = Vector2()
var mouse_sensitivity = 10

export(float) var rotation_speed = 200.0
export(float) var rotation_limit = 45.0

func _physics_process(delta):
	if mouse_rotation != Vector2.ZERO:
		vertical_gimbal.rotate_x(deg2rad(-mouse_rotation.y) * delta * mouse_sensitivity)
		horizontal_gimbal.rotate_y(deg2rad(-mouse_rotation.x) * delta * mouse_sensitivity)
		mouse_rotation = Vector2()
	else:
		var x_direction = Input.get_action_strength("camera_up") - Input.get_action_strength("camera_down")
		var y_direction = Input.get_action_strength("camera_left") - Input.get_action_strength("camera_right")
		var rotation_amount = deg2rad(rotation_speed * delta)
		var rotation_direction = Vector3(x_direction, y_direction, 0).normalized()
		if rotation_direction != Vector3.ZERO:
			vertical_gimbal.rotate_x(rotation_amount * rotation_direction.x)
			horizontal_gimbal.rotate_y(rotation_amount * rotation_direction.y)
	var outer_rotation = vertical_gimbal.rotation_degrees
	outer_rotation.x = clamp(outer_rotation.x, -rotation_limit, rotation_limit)
	vertical_gimbal.rotation_degrees = outer_rotation

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		print(event)
		mouse_rotation = event.relative