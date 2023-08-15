extends VBoxContainer

signal deselected()


func _physics_process(delta):
	if Input.is_action_just_pressed("attack"):
		_on_zoom_pressed()
	if Input.is_action_just_pressed("jump"):
		_on_zoomout_pressed()
	if Input.is_action_just_pressed("interact"):
		_on_Button3_pressed()
		

func should_deselect():
	return not $Button.p

func selected():
	$Button.grab_focus()
	show()


func deselect():
	hide()


func _on_Button4_pressed():
	deselect()
	emit_signal("deselected")


func _on_zoom_pressed():
	$"%Map".zoom = min($"%Map".zoom+1,4)


func _on_zoomout_pressed():
	$"%Map".zoom = max($"%Map".zoom-1,1)


func _on_Button3_pressed():
	$"%Map".update_wp()
