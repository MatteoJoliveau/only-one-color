extends Node

onready var player = $Player
onready var next_color_label = $UI/VBoxContainer/NextColor/ColorRect
onready var score_label = $UI/VBoxContainer/Score/Counter
onready var high_score_label = $UI/VBoxContainer/HighScore/Counter
onready var game_over: Popup = get_tree().root.find_node("GameOver", true, false)
var is_game_over = false
var high_score: int

func _ready():
	WorldGen.generate_world(self)
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
	if score > high_score:
		save_file.store_line(to_json({ 'score': score }))
	save_file.close()
	return score if score > high_score else high_score

func _update_high_score(new_high_score: int):
	high_score = new_high_score
	high_score_label.text = str(new_high_score)