extends Node

onready var player = $Player
onready var game_over: Popup = get_tree().root.find_node("GameOver", true, false)
var worldgen = WorldGen.new()

func _ready():
	worldgen.generate_world(self)
	player.connect("died", self, "_on_game_over")

func _on_game_over():
	game_over._pause()
	game_over.popup_centered()