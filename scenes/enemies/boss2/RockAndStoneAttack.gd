extends State


func _state_logic(delta):
	pass

func _enter_state(new,o):
	._enter_state(new,o)
	pass

func _get_transition(delta):
	$"%Dash".dir = (entity.global_position.direction_to($"%StatusThing".target.global_position))
	entity.dir = $"%Dash".dir 
	entity.dir *= -1
	return $"%Dash"
