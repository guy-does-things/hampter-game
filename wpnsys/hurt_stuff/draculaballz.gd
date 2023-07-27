extends GdtGun


func get_bullet_rotation(current_burst, current_pellet):
	var data = {
		0:-deg2rad(get_gun_data().data_res.spread),
		1:0,
		2:deg2rad(get_gun_data().data_res.spread)
	}

	return data[current_pellet%3]
			
