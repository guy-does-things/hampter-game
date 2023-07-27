extends GdtGun

export 	var data = {
		# left
		0:30,
		1:20,
		2:0,
		
		# right
		3:180,
		4:160,
		5:150,
		
		# top
		6:120,
		7:60
		
	}


func get_bullet_rotation(current_burst, current_pellet):
	
	return deg2rad(data[current_pellet%data.size()])


func _on_BouncyShoot_proj_created(proj:GdtBullet):
	yield(get_tree(),"idle_frame")
	proj.rotation = (-proj.dir).angle_to_point(Vector2.ZERO)
