# This script is model to create a new state for
# the finite state machine and some rules have to
# followed:
# 1. The StateMachine have to be this node's parent
# 2. This state have to be specified on STATES map in 
# StateMachine node as <State-Name> : self

extends Node

onready var character
onready var sm = get_parent()

func _enter(parent):
	character = parent

func _update(delta):
	pass

func _handle_input(event):
	pass

func _exit():
	pass
