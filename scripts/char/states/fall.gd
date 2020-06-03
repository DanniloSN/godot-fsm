extends Node

onready var character = get_owner()
onready var sm = get_parent()

const GRAVITY = 200
const AIR_HORIZONTAL_VELOCITY = 100

var velocity = 0
var runPressed = false

func _enter():
	character.playAnimation("Fall")

	# Define fall horizontal velocity
	velocity = character.movement.x if abs(character.movement.x) > AIR_HORIZONTAL_VELOCITY else AIR_HORIZONTAL_VELOCITY

func _update(delta):
	# If isn't on floor set state to Fall
	if !character.is_on_floor():
		# Apply gravity
		character.movement.y += GRAVITY * delta

		# Set the movement as air velocity
		character.movement.x = character.direction.x * abs(velocity)

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
	runPressed = Input.is_action_pressed("run")

	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

	if Input.is_action_pressed("attack"):
		sm.setState("AirAttack")

func _exit():
	velocity = 0
