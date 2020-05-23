# Basicly just stand still waiting for
# some input or scenario change
extends Node

onready var character
onready var sm = get_parent()

var runPressed = false

func _enter(parent):
	character = parent
	character.playAnimation("Idle")

	# Set movement variables to zero
	character.direction = Vector2()
	character.movement = Vector2()

func _update(delta):
	# Check the floor
	if !character.is_on_floor():
		sm.setState("Fall")

	# If the direction is zero, then set
	# state to Walk or Run depeding if is
	# pressing the run button.
	if character.direction != Vector2():
		if runPressed:
			sm.setState("Run")
		else:
			sm.setState("Walk")
	else:
		character.movement = Vector2()

func _handle_input(event):
	# While pressing run, runPressed will be
	# true, that will decide if is going to
	# run or walk
	if Input.is_action_pressed("run"):
		runPressed = true
	else:
		runPressed = false

	# Set state to Jump
	if Input.is_action_pressed("jump"):
		sm.setState("Jump")

	# If press move_left or move_right, 
	# change the direction
	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

	# Set state to Attack
	if Input.is_action_pressed("attack"):
		sm.setState("Attack")

func _exit():
	pass
