extends ActionState


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var landed = false


func action_check(dt):
	.action_check(dt)
	var hurtbox :Node2D = hbshape.get_parent()
	
	
	
	for tick in 3:
		hurtbox.position.y = $"%Jumper".jump_force * dt
		var r = hit_test(hinfo.hitbox,hinfo.transf,hinfo.vel,tick)
		if not r.empty() or randf() < .2:
			return CheckValues.FAILED
	
	hurtbox.position.y = 0
	
	return CheckValues.SUCCESS_TRANS
	
	
func do_action(dt):
	$"%Jumper".jump()

func _get_transition(dt):
	if landed or entity.is_on_floor():
		landed = false
		return state_machine.get_node(state_machine.initial_state)




func _on_idle_landed():
	landed = true
