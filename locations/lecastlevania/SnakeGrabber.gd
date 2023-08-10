
extends Area2D


var snake : Entity
var max_s_attacks = 4
var snake_attacks = 0


func _physics_process(delta):
	
	if is_instance_valid(snake):
		snake.global_position = $CollisionShape2D.global_position
		snake.velocity = Vector2.ZERO
		snake.set_collision_mask_bit(5,true)
		
		
	
	if snake_attacks > max_s_attacks:
		$"%Platforms".open_mode = 0
		snake_attacks = 0
		snake = null
	
	


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
	if not is_instance_valid(snake):
		return
	
	
	
	var omode = (randi() % 6)+1
	while omode == $"%Platforms".open_mode:
		omode = (randi() % 6)+1
	
	$"%Platforms".open_mode = omode
	
	
	yield(get_tree().create_timer(1.5,false),"timeout")
	
	var rects = generate_snake_rects()
	
	for rect in rects:
		$"%gun".position = rect.get_center()
		$"%gun".position.y += 32
		
		
		$"%gun".dir = Vector2.ZERO
		$"%gun".actually_fire()
	
	#yield(get_tree().create_timer(.5,false),"timeout")
	snake_attacks += 1
	
	if not is_instance_valid(snake) or snake_attacks > max_s_attacks:
		$"%Platforms".open_mode = 0
		return
	$SnakeTimer.start()



func _on_gun_proj_created(proj):
	if not is_instance_valid(snake):return
	proj.customdata.target = snake.get_node("StatusThing").target
