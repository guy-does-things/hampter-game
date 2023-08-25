extends HBoxContainer

export var bus = "master"




func _ready():
	$Label3.text = bus
	match bus:
		"Master":
			$HSlider3.value = SavesManager.settings.master_volume
		"SFX":
			$HSlider3.value = SavesManager.settings.master_volume
	

func _on_HSlider3_value_changed(value):
	$Label3.text = str(bus,":",value*100,"%")
	
	match bus:
		"Master":
			SavesManager.settings.master_volume = value
		"SFX":
			SavesManager.settings.master_volume = value
			
		
	SavesManager.settings.emit_signal("changed_setting")
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus),linear2db(value))

