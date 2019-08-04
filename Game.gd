extends Node

onready var player = $Player
onready var next_color_label = get_tree().root.find_node("NextColor", true, false).find_node("ColorRect")
onready var score_label = get_tree().root.find_node("Score", true, false).find_node("Counter")
onready var high_score_label = get_tree().root.find_node("HighScore", true, false).find_node("Counter")
onready var countdown_label = get_tree().root.find_node("CountDown", true, false).find_node("Counter")
onready var color_timer = $ColorTimer
onready var pause_menu: Popup = get_tree().root.find_node("PauseMenu", true, false)
onready var game_over: Popup = get_tree().root.find_node("GameOver", true, false)
onready var seconds = $SecondsTicker
var is_game_over = false
var high_score: int

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	WorldGen.generate_world(self)
	seconds.connect("timeout", self, "_update_timer")
	player.connect("died", self, "_on_game_over")
	player.connect("changed_color", self, "_update_next_color")
	player.connect("scored", self, "_update_score")
	_update_score(player.score)
	_update_next_color(player.next_color)
	_update_high_score(_get_best_score())

func _update_next_color(color: Color):
	next_color_label.color = color

func _update_score(score: int):
	score_label.text = str(score)
	
func _on_game_over():
	if not is_game_over:
		is_game_over = true
		_update_high_score(_save_best_score(player.score))
		game_over._pause()

func _get_best_score():
	var save_file = File.new()
	save_file.open("user://scores.save", File.READ)
	var content = parse_json(save_file.get_line())
	save_file.close()
	return content.get('score', 0) if content != null else 0

func _save_best_score(score: int) -> int:
	var save_file = File.new()
	save_file.open("user://scores.save", File.WRITE)
	var new_high_score = max(score, high_score)
	save_file.store_line(to_json({ 
	'score': new_high_score 
	}))
	save_file.close()
	return new_high_score

func _update_high_score(new_high_score: int):
	high_score = new_high_score
	high_score_label.text = str(new_high_score)

func _update_timer():
	countdown_label.text = str(int(color_timer.time_left))

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause_menu") or event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			pause_menu._unpause()
		else:
			pause_menu._pause()