extends Node

onready var STATES = {
	"Idle" : $Idle,
	"Walk" : $Walk,
	"Run" : $Run,
	"Fall" : $Fall,
	"Jump" : $Jump
}

var previousState
var state

func setState(newState):
	# Just call _exit if has a previous state
	if state != null:
		state._exit()
		previousState = state

	# Set the new state and call _enter
	state = STATES[newState]
	state._enter(get_parent())

	# Just for debug
	var previousStateName = previousState.name if previousState != null else ""
	var stateName = state.name
	print(
		"Previous State: " + str(previousStateName) + "\n" +
		"Actual State: " + str(stateName) + "\n" 
	)
