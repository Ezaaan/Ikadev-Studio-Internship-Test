extends Node

# Available items
const ITEMS: PackedStringArray = ["Cherry", "Gem", "Box", "Frog"]
var score: int = 0
var player: CharacterBody2D = null
var freezeState: bool = false
const SAVE_PATH := "res://score.tres"

func _ready():
	# If no save file is detected, create new
	if(!FileAccess.file_exists(SAVE_PATH)):
		print("No resource detected")
		_save_score(0)

# Save highscore
func _save_score(value: int):
	ResourceSaver.save(ScoreData.new(value), SAVE_PATH)

# Load highscore
func _load_score()-> int:
	return ResourceLoader.load(SAVE_PATH).duplicate(true).HighScore

# Increase score
func _increase_score(value: int):
	var label: Label = player.get_node("Camera2D").get_node("ScoreText")
	score += value
	label.text = "Score: " + str(score)
	
# Freeze game
func _freeze_game():
	Engine.time_scale = 0
	freezeState = true

# Unfreeze game
func _unfreeze_game():
	Engine.time_scale = 1
	freezeState = false

# Pause game
func _pause_game():
	var pauseMenu: Panel = player.get_node("PauseMenu")
	pauseMenu.visible = true
	_freeze_game()

# Unpause game
func _unpause_game():
	var pauseMenu: Panel = player.get_node("PauseMenu")
	pauseMenu.visible = false
	_unfreeze_game()

# Game over
func _game_over():
	_freeze_game()
	# if score is bigger than current high score, set to high score
	if(score > _load_score()):
		_save_score(score)
	player.get_node("GameOver").visible = true
