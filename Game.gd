extends Node


onready var timer: Timer = $Timer
onready var pause_menu: Popup = get_tree().root.find_node("PauseMenu", true, false)
var worldgen = WorldGen.new()

func _ready():
	timer.connect("timeout", self, "_on_timer")	
	worldgen.generate_world(self)
