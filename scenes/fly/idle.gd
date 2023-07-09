extends State

var t = 0

export var tmult = 1
export var vel_mult = 1



func _state_logic(dt):
	entity.velocity = Vector2(sin(t),cos(t)) * vel_mult
	
	t+= dt * tmult


func _get_transition(dt):
	if $"%StatusThing".target:
		
		return state_machine.get_node(state_machine.initial_state)
