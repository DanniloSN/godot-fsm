extends Node

# The character's states have to be specified here
onready var STATES = {
	"Idle" : $Idle,
	"Walk" : $Walk,
	"Run" : $Run,
	"Jump" : $Jump,
	"Fall" : $Fall,
	"Attack" : $Attack,
}

var previousState
var state

var statesHistory = []

func setState(newState):
	# Just call _exit if has a previous state
	if state != null:
		state._exit()
		previousState = state

	# Set the new state and call _enter
	state = STATES[newState]
	state._enter(get_parent())

	# Debug purposes
	var previousStateName = previousState.name if previousState != null else ""
	var stateName = state.name
	print(
		"Previous State: " + str(previousStateName) + "\n" +
		"Actual State: " + str(stateName) + "\n" 
	)
