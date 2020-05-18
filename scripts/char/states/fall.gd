extends Node

onready var character
onready var sm = get_parent()

const GRAVITY = 200
const AIR_HORIZONTAL_VELOCITY = 200
const AIR_HORIZONTAL_ACCELERATION = 15

var velocity = Vector2()

var inputRun = false

func _enter(parent):
	character = parent
	character.direction.y = 1

	if character.movement.x == 0:
		velocity.x = character.movement.x

func _update(delta):
	# If isn't on floor set state to Fall
	if !character.is_on_floor():
		# Apply gravity
		character.movement.y += GRAVITY * delta

		# Smooth acceleration to move on air
		velocity = velocity.linear_interpolate(
			character.direction * AIR_HORIZONTAL_VELOCITY,
			AIR_HORIZONTAL_ACCELERATION * delta
		)

		# Set the movement as walk velocity
		character.movement.x = velocity.x

	else:
		# Check conditions to change state
		if character.direction.x == 0:
			sm.setState("Idle")
		else:
			if inputRun:
				sm.setState("Run")
			else:
				sm.setState("Walk")

func _handle_input(event):
	if Input.is_action_pressed("run"):
		inputRun = true
	else:
		inputRun = false

	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

func _exit():
	character.direction.y = 0
