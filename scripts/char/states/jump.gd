extends Node

onready var character
onready var sm = get_parent()

const JUMP_FORCE = 200
const GRAVITY = 200
const AIR_HORIZONTAL_VELOCITY = 200

var velocity = 0

func _enter(parent):
	character = parent
	character.playAnimation("Jump")

	# Define jump horizontal velocity
	velocity = character.movement.x if abs(character.movement.x) > AIR_HORIZONTAL_VELOCITY else AIR_HORIZONTAL_VELOCITY

	# Set the movement and direction
	character.movement.y = -JUMP_FORCE
	character.direction.y = -1

func _update(delta):
	# If touched the floor setState to Idle
	if !character.is_on_floor():
		# Apply gravity
		character.movement.y += GRAVITY * delta

	# Set the movement as walk velocity
	character.movement.x = character.direction.x * abs(velocity)

	# If is falling setState to Fall
	if character.movement.y > 0:
		sm.setState("Fall")


func _handle_input(event):
	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

func _exit():
	velocity = 0
