extends Node

# warning-ignore:unused_class_variable
var colors = [
	Color.red,
	Color.green,
	Color.blue,
#	Color.yellow,
#	Color.aquamarine,
#	Color.blueviolet,
#	Color.pink
]

func get_random_color() -> Color:
	randomize()
	var colors = self.colors.duplicate()
	colors.shuffle()
	return colors[randi() % colors.size()]