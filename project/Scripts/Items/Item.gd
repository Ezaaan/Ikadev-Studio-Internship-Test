extends Area2D

@onready
var audio: AudioStreamPlayer2D = get_node("Sfx")
var inRange: bool = false

func _process(delta):
	# If player presses key and is in range of item, pick up item
	if(Input.is_key_pressed(KEY_K) && inRange):
		audio.play(0.2)
		Game.player._update_holditem(self.name)

# Player is in range of item
func _on_body_entered(body):
	if(body.name == "Player"):
		inRange = true

# Player is not in range of item anymore 
func _on_body_exited(body):
	if(body.name == "Player"):
		inRange = false
