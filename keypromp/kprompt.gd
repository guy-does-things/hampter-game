extends PanelContainer

var is_ctr = false

func _input(event):
	if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and not is_ctr:
		$"%Label".text =  RemapContainer.input_data_to_str(SavesManager.settings.current_controller_mappings["interact"])
		is_ctr= true
		
	if (event is InputEventKey) and is_ctr:
		$"%Label".text =  RemapContainer.input_data_to_str(SavesManager.settings.current_keys["interact"])
		is_ctr = false


		
func _ready():
	$"%Label".text =  RemapContainer.input_data_to_str(SavesManager.settings.current_keys["interact"])
	

