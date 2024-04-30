extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready
var animation: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	Game.player = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("Jump")
	
	if(velocity.y > 0):
		animation.play("Fall")

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	
	# Handle jump.
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation.play("Idle")
	move_and_slide()
