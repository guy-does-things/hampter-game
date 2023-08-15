extends Button


var p = false


func _physics_process(delta):
	if p:
		grab_focus()
		if Input.is_action_just_pressed("ui_cancel"):p = false
	
	$Panel/ViewportContainer/Viewport/Map.can_move_cursor = p
	$Panel/ViewportContainer/Viewport/Map.set_inv(!is_visible_in_tree())

func _on_Button_pressed():
	p = true
