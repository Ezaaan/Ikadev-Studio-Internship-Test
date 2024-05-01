extends Node2D

@onready var highScoreText = $MarginContainer/VBoxContainer/HighScoreText
var score: int = 0

func _ready():
	# Load existing high score
	score = Game._load_score()
	highScoreText.text = "High Score: " + str(score)

# Direct to game
func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/DeliveryGuy.tscn")

# Close game
func _on_exit_button_pressed():
	get_tree().quit()
