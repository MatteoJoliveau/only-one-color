extends Node

# warning-ignore:unused_class_variable
var colors = [
	Color.red,
	Color.green,
	Color.blue,
]

func get_randomized_colors() -> Array:
	randomize()
	var colors = self.colors.duplicate()
	colors.shuffle()
	return colors

func get_random_color() -> Color:
	var colors = get_randomized_colors()
	return colors[randi() % colors.size()]