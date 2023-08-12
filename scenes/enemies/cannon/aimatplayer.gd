extends State




func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	yield(get_tree().create_timer(.1,false),"timeout")
	$Timer.start()
	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	$Timer.stop()


func _state_logic(delta):
	if not is_instance_valid($"%StatusThing".target):
		$"%Wheelattack".rotation = 0
		
		return
	
	
	var gravity = -20
	var tp :Vector2= $"%StatusThing".target.global_position

	
	$"%Wheelattack".look_at(tp)
	
	
	
	
	
	
	
	
	
	


	




func pipebombattack(vel,dir=Vector2.RIGHT,speed=200):
	var sattack = preload("res://bullets/cannonball.tscn").instance()

	sattack.global_position = entity.global_position + Vector2.DOWN *4
	sattack.damage = 1
	sattack.is_enemy = true
	sattack.lifetime = 10
	sattack.dir = dir
	sattack.speed = speed
	sattack.velocity = vel
	get_tree().current_scene.add_child(sattack)


func _on_Timer_timeout():
	var tp = $"%StatusThing".target
	if not is_instance_valid(tp):return
	$"%AudioStreamPlayer2D".play()
	tp = tp.global_position
	pipebombattack(
		Vector2(0,-200),
		Vector2.RIGHT.rotated($"%Wheelattack".rotation) * $"%Wheelattack".get_parent().scale,
		min(600,entity.global_position.distance_to(tp)*1.5)
	)
