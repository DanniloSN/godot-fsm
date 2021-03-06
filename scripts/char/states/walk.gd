extends Node

onready var character = get_owner()
onready var sm = get_parent()

const WALK_VELOCITY = 200
const WALK_ACCELERATION = 15

var velocity = Vector2()

func _enter():
	character.playAnimation("Walk")

func _update(delta):
	# Check the floor
	if !character.is_on_floor():
		sm.setState("Fall")

	# If have no direction, set state to Idle
	if(character.direction == Vector2()):
		sm.setState("Idle")

	# Smooth acceleration to walk
	velocity = velocity.linear_interpolate(
		character.direction * WALK_VELOCITY,
		WALK_ACCELERATION * delta
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

	# Start running
	if Input.is_action_pressed("run"):
		sm.setState("Run")

	# Set state to Attack
	if Input.is_action_pressed("attack"):
		sm.setState("Attack")

func _exit():
	velocity = Vector2()
