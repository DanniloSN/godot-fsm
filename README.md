# Godot FSM
This is an example of encapsulating a character's states using a fsm (Finite State Machine) model.

# How it works?
First of all let's talk about the structure:

![alt text](https://i.imgur.com/pluMYZi.png)

About the Nodes we have: 
* Parent KinematicBody2D,
* CollisionShape2D, 
* Sprite2D, 
* AnimationPlayer, 
* Raycast2D, 
* CanvasLayer (Just to hold some labels for debug),
* Node for FSM with the character's states as children.

Starting for the FSM Node Script:
* Store a map with the states,
* Store the active state,
* Have a function to change the state,
* The only one with directly access to other States.

Every state's script have his own:
* _enter method (will be executed when entered in this state, like play an animation),
* _update method (will process his behaviours and rules),
* _handle_input method (will process his inputs and methods that the state allows),
* _exit method (will be executed when change from this state to another).

The Kinematic Body script have the _process and _input method, that just access the FSM Node for _update and _handle_input methods from the active state.
