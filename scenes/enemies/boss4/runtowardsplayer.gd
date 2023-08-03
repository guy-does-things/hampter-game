extends FoxActionState


export var speed = 1
export var max_time = .5
var can_trans = true
var time = 0


func _state_logic(delta):
	entity.velocity.x += sign(entity.global_position.direction_to(
		$"%StatusThing".target.global_position
	).x) * speed
	time += delta

func _can_transition():
	return entity.global_position.distance_to(
		$"%StatusThing".target.global_position
	) > 64

func _get_transition(dt):
	var d = entity.global_position.distance_to(
		$"%StatusThing".target.global_position
	)
	
	
	if d <= 64 or time > max_time:
		time = 0
		return state_machine.get_node(state_machine.initial_state)
