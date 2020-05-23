extends Node

onready var character
onready var sm = get_parent()

const GRAVITY = 200
const AIR_HORIZONTAL_VELOCITY = 100

var velocity = 0
var runPressed = false
var isAttacking = false

func _enter(parent):
	character = parent

	# Define fall horizontal velocity
	velocity = character.movement.x if abs(character.movement.x) > AIR_HORIZONTAL_VELOCITY else AIR_HORIZONTAL_VELOCITY

	# Connect to animation node and play animation
	character.get_node("AnimationPlayer").connect("animation_finished", self, "finishAttackAnimation")
	character.playAnimation("AirAttack")
	isAttacking = true

func _update(delta):
	if !character.is_on_floor():
		# Apply gravity
		character.movement.y += GRAVITY * delta

		# Set the movement as air velocity
		character.movement.x = character.direction.x * abs(velocity)

		# If is falling setState to Fall
		if !isAttacking && character.movement.y > 0:
			sm.setState("Fall")

	else:
		if character.direction.x != 0:
			if runPressed:
				sm.setState("Run")
			else:
				sm.setState("Walk")
		else:
			sm.setState("Idle")

func _handle_input(event):
	# Run instead walk
	if Input.is_action_pressed("run"):
		runPressed = true
	else:
		runPressed = false

	# Change direction
	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

func finishAttackAnimation(attackAnimationFinished):
	isAttacking = false

func _exit():
	character.get_node("AnimationPlayer").disconnect("animation_finished", self, "finishAttackAnimation")
	isAttacking = false
	velocity = 0
