class_name RemapContainer
extends HBoxContainer
var is_k

var is_remapping = false

onready var btn = $Button

func _input(event):
	if not is_remapping:return
	if event is InputEventMouse:return
	
	if not event.is_pressed():return
	
	if is_k and not (event is InputEventKey):
		is_remapping = false
		$Button.text = "this isn't the right tab!"
		return
	
	if not is_k and event is InputEventKey:return
	
	if SavesManager.settings.change_key($Label.text,event):
		$Timer.stop()
		_on_Timer_timeout()

	
	

static func input_data_to_str(data:Array):
	if data[0] == Settings.InputSaveModes.KEYBOARD:
		return OS.get_scancode_string(data[1])
	
	if data[0] == Settings.InputSaveModes.CONTROLLERBUTTON:
	
		if data[1] in Globals.BUTTON_LOOKUP.COMMON.keys():
			return Globals.BUTTON_LOOKUP.COMMON[data[1]]
		
		return Globals.BUTTON_LOOKUP[
			Globals.BUTTON_LOOKUP.keys()[SavesManager.settings.controller_type]
		][data[1]]
	
	if data[0] == Settings.InputSaveModes.AXIS:
		var joy = "left joy" if data[1] == 0 or data[1] == 1 else "right joy"
		
		if data[1]==1 or data[1] == 3:
			joy = joy + (" down" if data[2] > 0 else " up")
			
		elif data[1]==0 or data[1] == 2:
			joy = joy + (" right" if data[2] > 0 else " left")
		
		if data[1] == 6:joy = "L2"
		elif data[1] == 7:joy = "R2"
		elif not data[1] in [0,1,2,3]:joy = "idk what joy it is"
		
		return joy

	return "???"


func setup(act_name:String,is_kb=false):
	SavesManager.settings.connect("changed_setting",self,"settings_changed")
	$Label.text = act_name
	is_k = is_kb
	
	if is_kb:
		$Button.text = input_data_to_str(SavesManager.settings.current_keys[act_name])
	else:
		$Button.text = input_data_to_str(SavesManager.settings.current_controller_mappings[act_name])


func settings_changed():
	if is_k:
		$Button.text = input_data_to_str(SavesManager.settings.current_keys[$Label.text])
	else:
		$Button.text = input_data_to_str(SavesManager.settings.current_controller_mappings[$Label.text])


func setup_focus(prev_btn=null):
	btn.focus_neighbour_bottom = btn.get_path()
	btn.focus_neighbour_left = btn.get_path()
	btn.focus_neighbour_top = btn.get_path()
	btn.focus_neighbour_right = btn.get_path()
	
	if prev_btn:
		btn.focus_neighbour_top = prev_btn.btn.get_path()
		prev_btn.btn.focus_neighbour_bottom = btn.get_path()
	
	




func _on_Button_pressed():
	
	Globals.remapping = true
	$Button.text = "PRESS BUTTON TO REMAP!"
	$Button.disabled = true
	is_remapping = true
	$Timer.start()
	


func _on_Timer_timeout():
	# required to avoid a loop with certain keys
	yield(get_tree().create_timer(.05),"timeout")
	
	Globals.remapping = false
	$Button.disabled = false
	is_remapping = false
	settings_changed()
