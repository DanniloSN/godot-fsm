# In this script we're going to manage
# the states by adding the state's node
# in the "STATES" map.
extends Node

# The character's states have to be specified here
# as { "state-name" : state-node }
onready var STATES = {
	"Idle" : $Idle,
	"Walk" : $Walk,
	"Run" : $Run,
	"Jump" : $Jump,
	"Fall" : $Fall,
	"Attack" : $Attack,
	"AirAttack" : $AirAttack
}

var previousState
var state

func setState(newState):
	# Just call state's "_exit" if has a previous/active state
	if state != null:
		# Any last word?
		state._exit()
		previousState = state

	# Set the new state and call his "_enter"
	state = STATES[newState]
	state._enter(get_parent())

	# Debug purposes
	var previousStateName = previousState.name if previousState != null else ""
	var stateName = state.name
	print(
		"Previous State: " + str(previousStateName) + "\n" +
		"Actual State: " + str(stateName) + "\n" 
	)
