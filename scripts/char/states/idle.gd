extends Node

onready var character
onready var sm = get_parent()

var runPressed = false

func _enter(parent):
	character = parent
	character.direction = Vector2()
	character.velocity = Vector2()

func _update(delta):
	# If isn't on ground setState Falling
	if !character.is_on_ground():
		sm.setState("Fall")

	if character.direction != Vector2():
		if runPressed:
			sm.setState("Run")
		else:
			sm.setState("Walk")

func _handle_input(event):
	# If run pressed, set state to Run instead Walk
	if Input.is_action_pressed("run"):
		runPressed = true
	else:
		runPressed = false

	# Jump
	if Input.is_action_pressed("jump"):
		sm.setState("Jump")

	# If press something change into his State
	if Input.is_action_just_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_just_pressed("move_right"):
		character.direction.x = 1

func _exit():
	pass
