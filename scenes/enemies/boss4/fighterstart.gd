extends State


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func initialize(en, statmach):
	.initialize(en, statmach)
	for state in get_children():
		state_machine.add_state(state)


func _state_logic(dt):
	if not $"%StatusThing".target:return
	
	for s in get_children():
		var state :ActionState = s
		var check = s.action_check(dt)
		if check == ActionState.CheckValues.SUCCESS_TRANS:
			state_machine.set_state(s)
		
		if check != ActionState.CheckValues.FAILED:
			s.do_action(dt)
			break
	


	
	
