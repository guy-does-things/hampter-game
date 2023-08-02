extends ActionState



func action_check(dt):
	.action_check(dt)
	
	
	return CheckValues.SUCCESS_NOTRANS
	
	
func do_action(dt):
	entity.velocity.x = -200 * sign(entity.global_position.direction_to(hinfo.transf.origin).x)
