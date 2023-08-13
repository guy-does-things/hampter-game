extends State


var dir:Vector2
func _state_logic(dt):
	dir = entity.global_position.direction_to($"%StatusThing".target.global_position)
	entity.velocity += dir * (10 if entity.global_position.distance_to($"%StatusThing".target.global_position) > 80 else 5)


func _on_HurtComponent_hurted(dam, is_water):
	entity.velocity = dir * -(100+(dam*25))
	
