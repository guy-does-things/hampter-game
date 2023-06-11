extends Camera2D

var zoom_level = 1

func _input(event):
		
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_level -= .02
				zoom_level = max(.2,zoom_level)
				zoom = Vector2.ONE * zoom_level
				
			
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_level += .02
				zoom_level = min(2,zoom_level)
				zoom = Vector2.ONE * zoom_level
				
				
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position += $Node.current_dir * 10
	
