extends ActionState



var can_do_act = true


func action_check(dt):
	.action_check(dt)
	
	if not randf() <= .4 or not can_do_act:
		return CheckValues.FAILED
	
	
	var projectiles_exist = get_tree().get_nodes_in_group("plrproj").size() > 0
	var player_weapon :MeleeWeapon= $"%StatusThing".target.entity.get_node("Node2D2/HampterSprite/Node2D") as MeleeWeapon
	var is_using_melee = false
	var enabled_hitbox:HitBox
	
	
	for hitbox in player_weapon.get_node("HitBoxes").get_children():
		if (hitbox as HitBox).monitoring:
			is_using_melee = true
			enabled_hitbox = hitbox
			# breaking because the player can only do one attack at once
			break
	
	var hit_result = null
	
	
	if enabled_hitbox != null:
		var hitbox_shape :CollisionShape2D = enabled_hitbox.get_child(1)
		# checks if halberd swing will hit
		
		var res = hit_test(hitbox_shape.shape,hitbox_shape.global_transform,$"%StatusThing".target.entity.velocity*dt)
		
		if !res.empty():
			hit_result = res
			hinfo.hitbox = hitbox_shape.shape
			hinfo.transf = hitbox_shape.global_transform
			hinfo.vel = $"%StatusThing".target.entity.velocity*dt
			hinfo.frame = Engine.get_idle_frames()
	
	
	for p in get_tree().get_nodes_in_group("plrproj"):
		var b :GdtBullet = p
		var res = hit_test(b.hitbox,b.global_transform,b.get_velocity(dt))
		if res:
			hit_result = res
			hinfo.hitbox = b.hitbox
			hinfo.transf = b.global_transform
			hinfo.vel = b.get_velocity(dt)
			hinfo.frame = Engine.get_idle_frames()

	return CheckValues.SUCCESS_NOTRANS if hit_result != null else CheckValues.FAILED


func do_action(dt):
	for s in get_children():
		var state :ActionState = s
		state.hinfo = hinfo.duplicate()
		var check = s.action_check(dt)
		
		if check == ActionState.CheckValues.SUCCESS_TRANS:
			state_machine.set_state(s)
		
		if check != ActionState.CheckValues.FAILED:
			s.do_action(dt)
			break
	
	can_do_act = false
	yield(get_tree().create_timer(.5,false),"timeout")
	can_do_act = true
	


	
