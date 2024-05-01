extends Panel	

# Resume's game
func _resume_game():
	Game._unpause_game()
	
# Quit to Main Menu
func _quit_game():
	_resume_game()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
