extends Node2D

@onready var highScoreText = $MarginContainer/VBoxContainer/HighScoreText
var Score: ScoreData = ScoreData.new()

func _ready():
	Score._load_score()
	highScoreText.text = "High Score: " + str(Score.HighScore)


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://DeliveryGuy.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
