extends State


func _enter_state(new,old):
	._enter_state(new,old)
	var dir = sign(entity.global_position.direction_to(
		$"%StatusThing".target.global_position
	).x)
	
	entity.velocity = Vector2(dir*250,-500)


func _get_transition(dt):
	if entity.is_on_floor():
		$"%AnimationPlayer".play("RESET")
		return $"%RandomAttacks"
