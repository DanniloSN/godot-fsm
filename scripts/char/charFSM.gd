extends KinematicBody2D

onready var sm = $StatesMachine

# Those variables are globaly 
# necessary to move the character
var direction = Vector2()
var movement = Vector2()

func _ready():
	sm.setState("Fall")

func _process(delta):
	if(sm.state):
		sm.state._update(delta)
	move_and_slide(movement, Vector2.UP)

func _input(event):
	if(sm.state):
		sm.state._handle_input(event)
