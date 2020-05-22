extends Node

onready var character
onready var sm = get_parent()

const MAX_ATTACKS = 3

var attackCombo = 1
var continueAttack = false

func _enter(parent):
	character = parent

	character.get_node("AnimationPlayer").connect("animation_finished", self, "finishAttack")
	character.playAnimation("AttackCombo" + str(attackCombo))

func _update(delta):
	# Check the floor
	if !character.is_on_floor():
		sm.setState("Fall")

func _handle_input(event):
	if Input.is_action_just_pressed("attack") and attackCombo < MAX_ATTACKS:
		continueAttack = true

func finishAttack(attackFinished):
	if continueAttack:
		attackCombo += 1
		continueAttack = false
		character.playAnimation("AttackCombo" + str(attackCombo))
	else:
		sm.setState("Idle")

func _exit():
	character.get_node("AnimationPlayer").disconnect("animation_finished", self, "finishAttack")
	attackCombo = 1
	continueAttack = false
