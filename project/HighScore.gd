extends Resource
class_name ScoreData

const SAVE_PATH := "res://score.tres"
@export var HighScore: int = 0

func _init(highScore=0):
	HighScore = highScore	
	if(!DirAccess.dir_exists_absolute(SAVE_PATH)):
		_save_score()

func _update_score(value: int):
	HighScore = value
	
func _save_score():
	ResourceSaver.save(self, SAVE_PATH)

func _load_score():
	return ResourceLoader.load(SAVE_PATH).duplicate(true)
