extends Node

var STATES = {}

var previousState
var state

func _ready():
	addState("Idle", $Idle)
	addState("Walk", $Walk)
	addState("Run", $Run)
	addState("Jump", $Jump)
	addState("Fall", $Fall)
	addState("Attack", $Attack)
	addState("AirAttack", $AirAttack)
	setState("Fall")

func addState(stateName, stateNode):
	STATES[stateName] = stateNode

func setState(newState):
	if state != null:
		previousState = state
		state._exit()

	state = STATES[newState]
	state._enter()

	# Debug purposes
	var previousStateName = previousState.name if previousState != null else ""
	var stateName = state.name
	print(
		"Previous State: " + str(previousStateName) + "\n" +
		"Actual State: " + str(stateName) + "\n" 
	)
