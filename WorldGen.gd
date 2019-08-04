extends Node

var Platform = preload("res://platform/Platform.tscn")
var total_rows = 30
var oldest_row: Vector3
var newest_row: Vector3
var x_distance = 27
var z_distance = 17
var deletion_timer: Timer

func generate_world(root: Node):
	deletion_timer = root.find_node("DeletionTimer")
	deletion_timer.connect("timeout", self, "shift_rows", [root])
	var start = root.find_node("Start")
	oldest_row = start.translation
	oldest_row.x -= x_distance * 3
	newest_row = start.translation
	for _i in range(0, total_rows):
		newest_row.x += x_distance
		newest_row = generate_row(root, newest_row)

func shift_rows(parent: Node):
	var first_row = newest_row
	first_row.x += x_distance
	
	var last_row = oldest_row
	last_row.x += x_distance
	
	newest_row = generate_row(parent, first_row)
	oldest_row = delete_row(parent, last_row)
	deletion_timer.start()

func generate_row(parent: Node, at: Vector3):
	var colors = Colors.get_randomized_colors()
	for j in range(0, colors.size()):
		var coeff = j - 1
		var color = colors[j]
		var new_platform = Platform.instance()
		new_platform.color = color
		new_platform.translation = at
		new_platform.translation.z = at.z + z_distance * coeff
		parent.add_child(new_platform)
	return at

func delete_row(parent: Node, at: Vector3):
	var platforms = _get_current_platforms()
	for platform in platforms:
		if platform.translation.x == at.x:
			parent.remove_child(platform)
	return at

func _get_current_platforms() -> Array:
	return get_tree().get_nodes_in_group("platforms")

func _random_number(max_num: int) -> int:
	return ((randi() % max_num - 1) + 1) * 5