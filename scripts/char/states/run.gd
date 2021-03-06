extends Node

onready var character = get_owner()
onready var sm = get_parent()

const RUN_VELOCITY = 300
const RUN_ACCELERATION = 15

var velocity = Vector2()

func _enter():
	character.playAnimation("Run")

func _update(delta):
	# Check the floor
	if !character.is_on_floor():
		sm.setState("Fall")

	# If have no direction, set idle
	if(character.direction == Vector2()):
		sm.setState("Idle")

	# Smooth acceleration to walk
	velocity = velocity.linear_interpolate(
		character.direction * RUN_VELOCITY,
		RUN_ACCELERATION * delta
	)

	# Set the movement as walk velocity
	character.movement.x = velocity.x

func _handle_input(event):
	# Can change directions
	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

	# Jump
	if Input.is_action_pressed("jump"):
		sm.setState("Jump")

	# Stop running
	if Input.is_action_just_released("run"):
		sm.setState("Walk")

	# Set state to Attack
	if Input.is_action_pressed("attack"):
		sm.setState("Attack")

func _exit():
	velocity = Vector2()
