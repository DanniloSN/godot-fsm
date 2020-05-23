# This is my model of a Finite State Machine
# for a KinematicCharacter2D, I choose to do
# this way because it was the simplest I get
# from some other that I readed.

extends KinematicBody2D

onready var sm = $StatesMachine

# These variables are originally from the character
# so we gonna keep them here as others behaviours to
# the active state manage them.
var direction = Vector2()
var movement = Vector2()

func _ready():
	sm.setState("Fall")

func _process(delta):
	# Each state have his own process called
	# "update" that will be process here.
	if(sm.state):
		sm.state._update(delta)

	# Exclusive from Character, so 
	# change based on his direction.
	if direction.x < 0:
		$Sprite.scale.x = -1
	elif direction.x > 0:
		$Sprite.scale.x = 1
	else:
		pass

	# Move character
	move_and_slide(movement, Vector2.UP)

	# Just for Debug
	$Debug/Char.text = \
		"Direction: " + str(direction) + "\n" + \
		"Movement: " + str(movement)

func _input(event):
	# Use input from actual state
	if(sm.state):
		sm.state._handle_input(event)

# I choose to override the "is_on_floor" method
# because it work only after KinematicBody2D's
# move functions are called, and that get a little
# buggy when we change from some state to others.
func is_on_floor():
	return $FloorRayCast.is_colliding()

# Play an animation
func playAnimation(animation):
	$AnimationPlayer.current_animation = animation
