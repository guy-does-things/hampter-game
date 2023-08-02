extends ActionState


func action_check(dt):
	.action_check(dt)
	
#	if not randf() >= .6:
#		return false
	return CheckValues.SUCCESS_NOTRANS


func do_action(dt):
	for s in get_children():
		var suc = s.action_check(dt)
		if suc == CheckValues.SUCCESS_TRANS:
			state_machine.set_state(s)
		
		if suc != CheckValues.FAILED:
			s.do_action(dt)
			break
	
