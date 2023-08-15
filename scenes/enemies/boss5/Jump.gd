extends State



func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	$"%AnimationPlayer".play_anim("speeen",1)
	$"%Jumper".jump_force = -900
	$"%Jumper".jump()
	(entity as KinematicBody2D).set_collision_mask_bit(5,false)
	(entity as KinematicBody2D).set_collision_mask_bit(19,false)
	


func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)



func _get_transition(dt):
	
	if abs(entity.velocity.y) < 11:
		$"%AnimationPlayer".stop()
	
	if entity.is_on_floor():
		(entity as KinematicBody2D).set_collision_mask_bit(19,true)
		return $"%Intro"


func _on_idle_landed():
	pass
	#$(entity as KinematicBody2D).set_collision_mask_bit(19,true)
	
