class_name Stun 
extends State

var t := Timer.new()
export var wait_time = 1.2


func _ready():
	add_child(t)
	t.wait_time = wait_time
	t.one_shot = true


func _enter_state(new_state, old_state):

	._enter_state(new_state, old_state)
	t.start()
	
func _get_transition(dt):
	if t.is_stopped():
		return state_machine.get_node(state_machine.initial_state)
