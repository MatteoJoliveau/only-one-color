extends Popup
class_name GameOver

onready var restart_button: Button = $VBoxContainer/RestartButton
onready var quit_button: Button = $VBoxContainer/QuitButton

func _ready():
	restart_button.connect("pressed", self, "_on_restart_pressed")
	quit_button.connect("pressed", self, "_on_quit_pressed")

func _on_restart_pressed():
	_unpause()
	get_tree().reload_current_scene()
	

func _on_quit_pressed():
	get_tree().quit()
	
func _pause():
	get_tree().paused = true
	popup_centered()

func _unpause():
	get_tree().paused = false
	hide()