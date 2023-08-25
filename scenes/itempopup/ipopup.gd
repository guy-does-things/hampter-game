extends Control




var is_ctr = false

func _input(event):
	if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and not is_ctr:
		$"%ExitL".text = "press " + RemapContainer.input_data_to_str(SavesManager.settings.current_controller_mappings["ui_accept"]) + " to exit"
		is_ctr= true
		
	if (event is InputEventKey) and is_ctr:
		$"%ExitL".text = "press " + RemapContainer.input_data_to_str(SavesManager.settings.current_keys["ui_accept"]) + " to exit"
		is_ctr = false
		


func _ready():
	$"%ExitL".text = "press " + RemapContainer.input_data_to_str(SavesManager.settings.current_keys["ui_accept"]) + " to exit"
	
func item_unlocked(item,loaded):
	#return
	if loaded:return
	
	
	for itemd in Globals.item_data:
		if itemd.item_id == item:
			$VBoxContainer2/PanelContainer/VBoxContainer/Label.text = (itemd as ItemData).item_name
			$VBoxContainer2/PanelContainer/VBoxContainer/Label2.text = (itemd as ItemData).item_desc
			Globals.can_open_menu = false
			get_tree().paused = true
	
	show()
	
	
	
func _physics_process(delta):
	if visible and Input.is_action_pressed("ui_accept"):
		Globals.can_open_menu = true
		get_tree().paused = false
		hide()
