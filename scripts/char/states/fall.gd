extends Node

onready var character
onready var sm = get_parent()

const GRAVITY = 200
const AIR_HORIZONTAL_VELOCITY = 100

var inputRun = false

func _enter(parent):
	character = parent
	character.direction.y = 1
	if character.velocity.x == 0:
		character.velocity.x = AIR_HORIZONTAL_VELOCITY
	character.velocity.y = GRAVITY

func _update(delta):
	# If isn't on ground setState Falling
	if character.is_on_ground():
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
	character.velocity.y = 0
