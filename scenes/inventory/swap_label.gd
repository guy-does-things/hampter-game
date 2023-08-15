extends Panel

onready var l = $Label
export(bool) var is_l = false
var pressed_ctr = false

func _input(event):
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		pressed_ctr = true
		
	if event is InputEventKey:
		pressed_ctr = false


func _process(delta):
	if pressed_ctr:
		l.text = RemapContainer.input_data_to_str(SavesManager.settings.current_controller_mappings["settings_left" if is_l else "settings_right"])
	else:
		l.text = RemapContainer.input_data_to_str(SavesManager.settings.current_keys["settings_left" if is_l else "settings_right"])
