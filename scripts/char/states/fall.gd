extends Node

onready var character
onready var sm = get_parent()

const GRAVITY = 200
const AIR_HORIZONTAL_VELOCITY = 200
const AIR_HORIZONTAL_ACCELERATION = 15

var velocity = Vector2()

var runPressed = false

func _enter(parent):
	character = parent
	character.playAnimation("Fall")

	character.direction.y = 1

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

	# Touched the floor
	else:
		if character.direction.x != 0:
			if runPressed:
				sm.setState("Run")
			else:
				sm.setState("Walk")
		else:
			sm.setState("Idle")

func _handle_input(event):
	if Input.is_action_pressed("run"):
		runPressed = true
	else:
		runPressed = false

	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

func _exit():
	character.direction.y = 0
