extends Node

onready var character = get_owner()
onready var sm = get_parent()

const MAX_ATTACKS = 3

var attackCombo = 1
var continueAttack = false

var runPressed = false

func _enter():
	# Set the character movement and direction to 0
	character.direction = Vector2()
	character.movement = Vector2()

	# Connect to animation node and play animation
	character.get_node("AnimationPlayer").connect("animation_finished", self, "finishAttackAnimation")
	character.playAnimation("AttackCombo" + str(attackCombo))

func _update(delta):
	# Check the floor
	if !character.is_on_floor():
		sm.setState("Fall")

func _handle_input(event):
	# Continue combo attack
	if Input.is_action_just_pressed("attack") and attackCombo < MAX_ATTACKS:
		continueAttack = true

	# Change direction
	if Input.is_action_pressed("move_left"):
		character.direction.x = -1
	elif Input.is_action_pressed("move_right"):
		character.direction.x = 1
	else:
		character.direction.x = 0

	# If is pressing run
	# setState to Run instead walk
	runPressed = Input.is_action_pressed("run")

func finishAttackAnimation(attackAnimationFinished):
	if continueAttack:
		attackCombo += 1
		continueAttack = false
		character.playAnimation("AttackCombo" + str(attackCombo))
	else:
		if character.direction.x != 0:
			if runPressed:
				sm.setState("Run")
			else:
				sm.setState("Walk")
		else:
			sm.setState("Idle")

func _exit():
	character.get_node("AnimationPlayer").disconnect("animation_finished", self, "finishAttackAnimation")
	attackCombo = 1
	continueAttack = false
