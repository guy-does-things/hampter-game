extends Area2D


var platthing = null



func _physics_process(delta):
	var ziplinedata = get_collision_point() 
#	print(ziplinedata)
	if ziplinedata and not get_parent().is_riding():
		if Input.is_action_just_pressed("platform"):
			if !is_instance_valid(platthing):
				platthing = preload("res://scenes/thing/Entity.tscn").instance()
				platthing.global_position = ziplinedata[0]
				platthing.zipline = ziplinedata[1]
				platthing.scale = Vector2.ONE * 2
				get_tree().current_scene.add_child(platthing)
			
			elif !get_parent().on_p:
				platthing.zipline = ziplinedata[1]
				platthing.global_position = ziplinedata[0]
				get_parent().global_position = ziplinedata[0] + (Vector2.DOWN * 6)
				get_parent().velocity.y = 0
				
			#yield(get_tree(),"idle_frame")

func get_collision_point():
	for area in get_overlapping_areas():
		if not area.is_in_group("zipline"):continue

		for area_owner_id in area.get_shape_owners():
			for area_shape_id in area.shape_owner_get_shape_count(area_owner_id):
				var area_owner = area.shape_owner_get_owner(area_owner_id)
				var area_shape_2d = area.shape_owner_get_shape(area_owner_id, area_shape_id)
				var area_owner_global_transform = area_owner.global_transform
				var collision_points = _get_collision_points_with_shape(area_shape_2d, area_owner_global_transform)
				if collision_points:
					return [collision_points[0],area.get_parent()]
	return null


func _get_collision_points_with_shape(other_shape: Shape2D, other_global_transform: Transform2D) -> Array:
	var all_collision_points := []
	
	for owner_id in get_shape_owners():
		for shape_id in shape_owner_get_shape_count(owner_id):
			var owner = shape_owner_get_owner(owner_id)
			var shape_2d = shape_owner_get_shape(owner_id, shape_id)
			var owner_global_transform = owner.global_transform
			var collision_points = shape_2d.collide_and_get_contacts(owner_global_transform,
												other_shape,
												other_global_transform)
			if collision_points:
				for point in collision_points:
					all_collision_points.append(point)
	
	return all_collision_points
