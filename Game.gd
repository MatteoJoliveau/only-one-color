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
var timer: Timer = Timer.new()

func _ready():
	timer.set_wait_time(2)
	timer.set_autostart(true)
	timer.connect("timeout", self, "_on_timer")
	add_child(timer)

func get_random_color() -> Color:
	var colors = Game.colors.duplicate()
	colors.shuffle()
	return colors[randi() % colors.size()]