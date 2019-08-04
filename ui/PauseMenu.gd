extends GameOver

onready var resume_button = $VBoxContainer/ResumeButton

func _ready():
	resume_button.connect("pressed", self, "_on_resume_pressed")

func _on_resume_pressed():
	_unpause()

