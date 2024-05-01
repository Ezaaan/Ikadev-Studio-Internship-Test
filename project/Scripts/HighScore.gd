extends Resource
class_name ScoreData

const SAVE_PATH := "res://score.tres"
@export var HighScore: int = 0

func _init(highScore=0):
	HighScore = highScore
