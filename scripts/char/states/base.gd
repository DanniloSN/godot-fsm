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
