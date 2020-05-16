extends KinematicBody2D

onready var sm = $StatesMachine

var direction = Vector2()
var velocity = Vector2()

func _ready():
	sm.setState("Fall")

func _process(delta):
	if(sm.state):
		sm.state._update(delta)

	move_and_slide(
		Vector2(
			direction.x * velocity.x,
			direction.y * velocity.y
		)
	)

func _input(event):
	if(sm.state):
		sm.state._handle_input(event)

func is_on_ground():
	return $RayCastLeft.is_colliding() or $RayCastRight.is_colliding()
