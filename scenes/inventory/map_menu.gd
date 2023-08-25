extends VBoxContainer

signal deselected()


var is_ctr = false
func _input(event):
	if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and not is_ctr:
		$HBoxContainer/Button.text = str(RemapContainer.input_data_to_str(SavesManager.settings.current_controller_mappings["attack"]),":zoom")
		$HBoxContainer/Button2.text = str(RemapContainer.input_data_to_str(SavesManager.settings.current_controller_mappings["jump"]),":zoomout")
		$HBoxContainer/Button3.text =  str(RemapContainer.input_data_to_str(SavesManager.settings.current_controller_mappings["interact"]),":marker")
		$HBoxContainer/Button4.text  = str(RemapContainer.input_data_to_str(SavesManager.settings.current_controller_mappings["ui_cancel"]),":exit")
		is_ctr= true
		
	if (event is InputEventKey) and is_ctr:
		$HBoxContainer/Button.text = str(RemapContainer.input_data_to_str(SavesManager.settings.current_keys["attack"]),":zoom")
		$HBoxContainer/Button2.text = str(RemapContainer.input_data_to_str(SavesManager.settings.current_keys["jump"]),":zoomout")
		$HBoxContainer/Button3.text =  str(RemapContainer.input_data_to_str(SavesManager.settings.current_keys["interact"]),":marker")
		$HBoxContainer/Button4.text  = str(RemapContainer.input_data_to_str(SavesManager.settings.current_keys["ui_cancel"]),":exit")
		is_ctr = false

func _physics_process(delta):
	if not is_visible_in_tree():return
	
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
