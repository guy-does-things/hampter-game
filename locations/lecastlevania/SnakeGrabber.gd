tool
extends Area2D


var snake : Entity




func _physics_process(delta):
	if is_instance_valid(snake):
		snake.global_position = global_position
		snake.velocity = Vector2.ZERO
		snake.set_collision_mask_bit(5,true)
	


func _on_SnakeGrabber_body_entered(body):
	snake = body
	$SnakeTimer.start()



func generate_snake_rects():
	var snake_rects := []
	
	var starting_tm_pos_y = -17 * $"%Platforms".open_mode
	var cur_snake_rect = Rect2(Vector2.ZERO,Vector2(16,16))
	var rect_stored = false
	var has_entered_thing = false
	var has_entered_a_tile = false
	var plats = $"%Platforms"
	
	for x in 30:
		var atcoords = plats.get_cell_autotile_coord(x,starting_tm_pos_y)
		
		has_entered_thing = atcoords.y == 1

		if has_entered_thing:
			rect_stored = false
			has_entered_a_tile = true
			
			if cur_snake_rect.position.y == 0:
				cur_snake_rect.position.y = 272
				cur_snake_rect.position.x = x*16
			else:
				cur_snake_rect.size.x += 16
				
		elif has_entered_a_tile and not rect_stored:
			rect_stored = true
			snake_rects.append(cur_snake_rect)
			cur_snake_rect = Rect2(Vector2.ZERO,Vector2(16,16))
			
		
		
	return snake_rects


func _on_SnakeTimer_timeout():
	
	$"%Platforms".open_mode = (randi() % 3)+1
	
	var rects = generate_snake_rects()
	
	for rect in rects:
		$"%gun".position = rect.get_center()
		
		$"%gun".dir = Vector2.ZERO
		$"%gun".actually_fire()		
	
	
	
	$SnakeTimer.start()
