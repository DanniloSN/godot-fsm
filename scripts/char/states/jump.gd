extends Node

onready var character
onready var sm = get_parent()

const JUMP_FORCE = 200
const GRAVITY = 200
const AIR_HORIZONTAL_VELOCITY = 200
const AIR_HORIZONTAL_ACCELERATION = 15

var velocity = Vector2()

func _enter(parent):
	character = parent
	character.playAnimation("Jump")

	# Set the movement and direction
	character.direction.y = -1
	character.movement.y = -JUMP_FORCE

func _update(delta):
	# If touched the floor setState to Idle
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
	velocity = Vector2()
