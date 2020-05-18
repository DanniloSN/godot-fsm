extends Node

onready var character
onready var sm = get_parent()

const JUMP_FORCE = 200

# This state is just a little push to jump
# and then set state to Fall
func _enter(parent):
	character = parent

	# Set the movement and direction
	character.direction.y = -1
	character.movement.y = -JUMP_FORCE

func _update(delta):
	# If isn't on floor set state to Fall
	if !character.is_on_floor():
		sm.setState("Fall")

func _handle_input(event):
	pass

func _exit():
	pass
