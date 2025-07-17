extends Node

var score : int
var high_score : int
var delta_accumulator : float
var player_dead := false
@onready var ship: Ship = $Player



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score = int(load_high_score())
	$UI/HighScore.text = "%d" % high_score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_dead:
		return
	
	if ship.global_position.y < -20.0:
		if high_score < score:
			$UI/HighScore.text = "%d" % score
			save_high_score(score)
			player_dead = true
			return	
		
	delta_accumulator += delta
	if delta_accumulator >= 1.0:
		var points = int(delta_accumulator)
		score += points
		update_score(score)
		delta_accumulator -= points
		

func update_score(score) -> void:
	$UI/Score.text = "%d" % score
	
func save_high_score(score):
	var content = str(score)
	var file = FileAccess.open("user://highscore.txt", FileAccess.WRITE)	
	if file:
		file.store_string(content)

func load_high_score():
	if not FileAccess.file_exists("user://highscore.txt"):
		return "0"
	var file = FileAccess.open("user://highscore.txt", FileAccess.READ)
	if file:
		return file.get_as_text()
