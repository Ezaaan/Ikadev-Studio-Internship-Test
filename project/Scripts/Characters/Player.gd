extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready
var animation: AnimationPlayer = get_node("AnimationPlayer")

var holdItem: String = ""

# Set the game's player
func _ready():
	Game.player = self

func _physics_process(delta):
	# If player pauses again in freeze state, unpause
	if(Game.freezeState && Input.is_action_just_pressed("pause")):
		Game._unpause_game()
	# If player pauses, freeze game
	elif(Input.is_action_just_pressed("pause")):
		Game._pause_game()
	
	# If game is in freeze state, player can't do anything
	if(Game.freezeState):
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("Jump")
	
	# Handle fall
	if(velocity.y > 0):
		animation.play("Fall")
	
	# Get direction
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Flip sprite according to direction
	if direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
		# If not moving in Y axis, handle run
		if velocity.y == 0:
			animation.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# If not moving in Y axis, handle idle		
		if velocity.y == 0:
			animation.play("Idle")
	move_and_slide()
	
# Update currently hold item
func _update_holditem(newItem: String):
	var panel: PanelContainer = Game.player.get_node("Camera2D").get_node("Panel")
	for item: Sprite2D in panel.get_children():
		if(item.name == newItem):
			item.visible = true
		else:
			item.visible = false
	holdItem = newItem

# Give currently hold item
func _give_item():
	var panel: PanelContainer = Game.player.get_node("Camera2D").get_node("Panel")
	for item: Sprite2D in panel.get_children():
		item.visible = false
	holdItem = ""
	Game._increase_score(100)

# Game over timer
func _on_timer_timeout():
	Game._game_over()
