extends MarginContainer

onready var new_game_button: Button = $Columns/Menu/Buttons/NewGame
onready var quit_button: Button = $Columns/Menu/Buttons/QuitButton

func _ready():
	new_game_button.connect("pressed", self, "_on_new_game")
	quit_button.connect("pressed", self, "_on_quit")

func _on_new_game():
	get_tree().change_scene("res://Game.tscn")

func _on_quit():
	get_tree().quit()