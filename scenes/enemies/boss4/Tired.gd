extends State


var not_tired = false

func _get_transition(dt):
	if not_tired:
		not_tired = false
		return state_machine.get_node(state_machine.initial_state)


func _on_Entity_recharged():
	not_tired = true
	pass # Replace with function body.
