extends KinematicBody2D

const GRAVITY = 200
const ACCELERATION = 15
const DECELERATION = 30
const WALK_VELOCITY = 200
const RUN_VELOCITY = 300
const JUMP_FORCE = 200

var direction = Vector2()
var velocity = Vector2()
var movement = Vector2()

var isRunning = false
var isOnFloor = true

func _ready():
	pass

func _process(delta):
	if !is_on_floor():
		isOnFloor = false
		movement.y += GRAVITY * delta
	else:
		isOnFloor = true

	var maxVelocity = 0
	if isRunning:
		maxVelocity = RUN_VELOCITY
	else:
		maxVelocity = WALK_VELOCITY

	var accel = false
	if direction.x != 0:
		accel = ACCELERATION
	else:
		accel = DECELERATION

	velocity = velocity.linear_interpolate(
		direction * maxVelocity,
		accel * delta
	)

	movement.x = velocity.x
	move_and_slide(movement, Vector2.UP)

func _input(event):
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
	else:
		direction.x = 0

	if isOnFloor and Input.is_action_pressed("run"):
		isRunning = true
	else:
		isRunning = false

	if isOnFloor && Input.is_action_just_pressed("jump"):
		jump()

func jump():
	movement.y = -JUMP_FORCE
