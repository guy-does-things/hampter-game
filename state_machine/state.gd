class_name State 
extends Node
signal entered()
signal exited()

export var can_go_to_hurtstate := true
var entity:Node2D
var state_machine


func initialize(en, statmach):
	entity = en
	state_machine = statmach
	

func _state_logic(delta):pass

func _enter_state(new_state, old_state):emit_signal("entered")
func _exit_state(old_state, new_state):emit_signal("exited")

func _get_transition(delta):pass
func _can_transition_to()-> bool:return true


func _can_transition_to_hurtstate()->bool:return can_go_to_hurtstate





