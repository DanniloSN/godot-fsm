extends Node

onready var character
onready var sm = get_parent()

const WALK_VELOCITY = 200

func _enter(parent):
	character = parent
	character.velocity.x = WALK_VELOCITY

func _update(delta):
	# If isn't on ground setState Falling
	if !character.is_on_ground():
		sm.setState("Fall")

	# If have no direction, set idle
	if(character.direction == Vector2()):
		sm.setState("Idle")

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

func _exit():
	pass
