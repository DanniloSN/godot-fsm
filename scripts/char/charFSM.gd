extends KinematicBody2D

onready var sm = $StatesMachine

# Those variables are globaly 
# necessary to move the character
var direction = Vector2()
var movement = Vector2()

func _ready():
	sm.setState("Fall")

func _process(delta):
	# Use process from actual state
	if(sm.state):
		sm.state._update(delta)

	# Invert sprite as needed
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

func is_on_floor():
	return $FloorRayCast.is_colliding()

# Play an animation
func playAnimation(animation):
	$AnimationPlayer.current_animation = animation
