extends Node

onready var character
onready var sm = get_parent()

const JUMP_FORCE = 200
const AIR_HORIZONTAL_VELOCITY = 100
var forceConsumerCount = JUMP_FORCE

func _enter(parent):
	character = parent
	character.direction.y = -1
	if character.velocity.x == 0:
		character.velocity.x = AIR_HORIZONTAL_VELOCITY
	character.velocity.y = JUMP_FORCE
	forceConsumerCount = JUMP_FORCE

func _update(delta):
	forceConsumerCount -= (JUMP_FORCE * 2) * delta
	print(forceConsumerCount)
	if forceConsumerCount <= 0:
		sm.setState("Fall")

func _handle_input(event):
	if Input.is_action_just_released("jump"):
		sm.setState("Fall")

	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

func _exit():
	pass
