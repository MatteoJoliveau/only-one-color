extends Popup

onready var resume_button = $VBoxContainer/ResumeButton
onready var restart_button = $VBoxContainer/RestartButton
onready var quit_button = $VBoxContainer/QuitButton

func _ready():
	resume_button.connect("pressed", self, "_on_resume_pressed")
	restart_button.connect("pressed", self, "_on_restart_pressed")
	quit_button.connect("pressed", self, "_on_quit_pressed")

func _on_resume_pressed():
	_unpause()

func _on_restart_pressed():
	get_tree().reload_current_scene()
	_unpause()

func _on_quit_pressed():
	get_tree().quit()

func _input(event: InputEvent):
	if event.is_action_pressed("pause_menu"):
		if get_tree().paused:
			_unpause()
		else:
			_pause()
	
func _pause():
	get_tree().paused = true
	popup_centered()

func _unpause():
	get_tree().paused = false
	hide()