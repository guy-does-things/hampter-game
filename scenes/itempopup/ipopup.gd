extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func item_unlocked(item,loaded):
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
