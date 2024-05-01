extends Area2D

@onready
var timer: Timer = get_node("Timer")
@onready
var panel: PanelContainer = get_node("PanelContainer")

var itemRequest: int
var inRange: bool = false
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# Generate initial request
func _ready():
	_set_new_request()

func _process(delta):
	# If item is correct and player is in range, accept the item
	if(inRange && Input.is_key_pressed(KEY_K) && Game.player.holdItem==Game.ITEMS[itemRequest]):
		_accept_item()
		timer.start()

# Player is in range
func _on_body_entered(body):
	if(body.name == "Player"):
		inRange = true

# Player is not in range anymore
func _on_body_exited(body):
	if(body.name == "Player"):
		inRange = false

# Cooldown for next request
func _on_timer_timeout():
	_set_new_request()
	timer.stop()

# Create new request
func _set_new_request():
	# Randomly pick the item
	itemRequest = rng.randi_range(0,3)
	panel.get_node(Game.ITEMS[itemRequest]).visible = true	

# Accept the item
func _accept_item():
	Game.player._give_item()
	get_node("Sfx").play()
	get_node("CPUParticles2D").emitting = true
	panel.get_node(Game.ITEMS[itemRequest]).visible = false
