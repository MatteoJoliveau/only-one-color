extends GameOver

onready var resume_button = $VBoxContainer/ResumeButton

func _ready():
	resume_button.connect("pressed", self, "_on_resume_pressed")

func _on_resume_pressed():
	_unpause()

func _input(event: InputEvent):
	if event.is_action_pressed("pause_menu"):
		if get_tree().paused:
			_unpause()
		else:
			_pause()