extends State





func _state_logic(delta):
	if not is_instance_valid($"%StatusThing".target):
		$"%Wheelattack".rotation = 0
		
		return
	
	
	var gravity = -20
	var tp :Vector2= $"%StatusThing".target.global_position

	
	$"%Wheelattack".look_at(tp)
	
	
	
	if Engine.get_idle_frames()%100!=0:return
	
	
	
	pipebombattack(
		Vector2(0,-200),
		Vector2.RIGHT.rotated($"%Wheelattack".rotation) * $"%Wheelattack".get_parent().scale,
		min(600,entity.global_position.distance_to(tp)*1.5)
	)


	




func pipebombattack(vel,dir=Vector2.RIGHT,speed=200):
	print(dir)
	var sattack = preload("res://bullets/pipebomb/pipebomb.tscn").instance()

	sattack.global_position = entity.global_position + Vector2.DOWN *4
	sattack.damage = 1
	sattack.is_enemy = true
	sattack.lifetime = 10
	sattack.dir = dir
	sattack.speed = speed
	sattack.velocity = vel
	get_tree().current_scene.add_child(sattack)
