extends Area2D

@onready
var timer: Timer = get_node("Timer")
@onready
var panel: PanelContainer = get_node("PanelContainer")

var itemRequest: int
var inRange: bool = false
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	_set_new_request()

func _process(delta):
	if(inRange && Input.is_key_pressed(KEY_E) && Game.holdItem==Game.ITEMS[itemRequest]):
		_accept_item()
		timer.start()

func _on_body_entered(body):
	if(body.name == "Player"):
		inRange = true

func _on_body_exited(body):
	if(body.name == "Player"):
		inRange = false

func _on_timer_timeout():
	_set_new_request()
	timer.stop()

func _set_new_request():
	itemRequest = rng.randi_range(0,3)
	panel.get_node(Game.ITEMS[itemRequest]).visible = true	

func _accept_item():
	panel.get_node(Game.ITEMS[itemRequest]).visible = false
	Game.score += 100
