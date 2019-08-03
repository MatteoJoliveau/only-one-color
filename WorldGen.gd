extends Node
class_name WorldGen

var Platform = preload("res://platform/Platform.tscn")
var platforms_to_gen = 10

func generate_world(root: Node):
	generate_platforms(root)

func generate_platforms(root: Node):
	var starting_translation = root.find_node("Start").translation
	var starting_z = starting_translation.z
	var previous_x = starting_translation.x
	print()
	for i in range(0, platforms_to_gen):
		previous_x += 20
		for j in range(0, 3):
			var coeff = j - 1
			var platform = Platform.instance()
			platform.translation.x = previous_x
			platform.translation.z = starting_z + 15 * coeff
			platform.translation.y = starting_translation.y
			root.add_child(platform)

func _random_number(max_num: int) -> int:
	return ((randi() % max_num - 1) + 1) * 5