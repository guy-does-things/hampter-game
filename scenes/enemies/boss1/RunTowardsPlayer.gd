extends State


export var speed = 1



func _state_logic(delta):
	entity.velocity.x += sign(entity.global_position.direction_to(
		$"%StatusThing".target.global_position
	).x) * speed


func _get_transition(dt):
	var d = entity.global_position.distance_to(
		$"%StatusThing".target.global_position
	)
	
	
	if d <= 48:
		return $"%UpperCutCharge"


func _on_Entity_lowhp():
	speed *= 1.5
