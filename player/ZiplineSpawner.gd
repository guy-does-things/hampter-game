extends Node2D


var platthing : Node2D


func _physics_process(delta):
	if not get_parent().status.has_item(Globals.Items.PLATFORM):return
	
	var colidata = {
		point=$RayCast2D.get_collision_point(),
		collider=$RayCast2D.get_collider()
	}
	
	if not colidata.collider:return
	
	if Input.is_action_just_pressed("platform"):
		var ppos = colidata.point
		
		ppos.y = colidata.collider.global_position.y+colidata.collider.get_parent().points[0].y
		#ppos.y += 4
		
		
		
		
		if !is_instance_valid(platthing):
			platthing = preload("res://scenes/thing/Entity.tscn").instance()
			platthing.global_position = ppos
			platthing.zipline = colidata.collider.get_parent()
			get_tree().current_scene.add_child(platthing)

		elif !get_parent().on_p:
			platthing.zipline = colidata.collider.get_parent()
			platthing.global_position = ppos
			get_parent().global_position = ppos + (Vector2.DOWN * 6)
			get_parent().velocity.y = 0
			
		platthing.ypos = ppos.y


#
#func _physics_process(delta):
#	var ziplinedata = get_collision_point() 
##	print_debug(ziplinedata)
#
#
#	if ziplinedata and not get_parent().is_riding():
#		
