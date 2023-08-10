extends Node2D



func _on_GdtBullet_startup(bullet):
	
	if bullet.customdata.get("target") == null:
		bullet.queue_free()
		return
	pass # Replace with function body.
	yield(create_tween().tween_property(
		bullet,
		"global_position:y",
		bullet.global_position.y - 96,
		.1
	),"finished")
	$Twinkl3.emitting = true
	
	yield(get_tree().create_timer(.4,false),"timeout")
	var tempd = global_position.direction_to(bullet.customdata.target.global_position)
	yield(get_tree().create_timer(.1,false),"timeout")
	bullet.dir = tempd
