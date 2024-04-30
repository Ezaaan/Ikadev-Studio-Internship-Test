extends Area2D

var inRange: bool = false
@onready
var audio: AudioStreamPlayer2D = get_node("Sfx")

func _process(delta):
	if(Input.is_key_pressed(KEY_K) && inRange):
		audio.play(0.2)
		Game._update_holditem(self.name)

func _on_body_entered(body):
	if(body.name == "Player"):
		inRange = true
		
func _on_body_exited(body):
	if(body.name == "Player"):
		inRange = false
