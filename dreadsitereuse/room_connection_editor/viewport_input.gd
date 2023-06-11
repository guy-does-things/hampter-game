extends Viewport

var zoom_level = 1
var is_dragging = false
var previous_campos := Vector2.ZERO

func _input(event):
	if get_parent().get_parent().visible:
		
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_level -= .02
				zoom_level = max(.2,zoom_level)
				$Camera2D.zoom = Vector2.ONE * zoom_level
				
			
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_level += .02
				zoom_level = min(2,zoom_level)
				$Camera2D.zoom = Vector2.ONE * zoom_level
				
			
			if event.button_index == BUTTON_MIDDLE:
				if event.is_pressed():
					previous_campos = event.position
				is_dragging = event.is_pressed()
				
		if event is InputEventMouseMotion:
			if is_dragging:
				$Camera2D.position += previous_campos - event.position
				previous_campos = event.position


func _on_Button2_pressed():
	$Camera2D.position = Vector2.ZERO
	zoom_level = 1
	$Camera2D.zoom = Vector2.ONE * zoom_level
	pass # Replace with function body.
