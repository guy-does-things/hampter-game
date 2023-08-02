extends State


export var speed = 1
var can_trans = true




func _state_logic(delta):
	entity.velocity.x += sign(entity.global_position.direction_to(
		$"%StatusThing".target.global_position
	).x) * speed


func _get_transition(dt):
	var d = entity.global_position.distance_to(
		$"%StatusThing".target.global_position
	)
	
	if d <= 64 or $"%StatusThing".is_full():
		return state_machine.get_node(state_machine.initial_state)
