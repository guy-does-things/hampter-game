extends Control

signal deselected()

func should_deselect():return true

func _ready():
	$TabContainer/Main/settings/OptionButton.selected = SavesManager.settings.controller_type-1

func selected():
	show()
	match $TabContainer.current_tab:
		0:
			$Button.focus_neighbour_top = $TabContainer/Main/settings/OptionButton.get_path()
		1:
			$Button.focus_neighbour_top = $TabContainer/Keyboard/settings.last_btp.btn.get_path()
		2:
			$Button.focus_neighbour_top = $TabContainer/Controller/settings.last_btp.btn.get_path()
	
	$Button.grab_focus()


func deselect():
	hide()


func _on_Button_pressed():
	deselect()
	emit_signal("deselected")


func inc_tab(tabinc):
	var ntab = $TabContainer.current_tab + tabinc
	ntab %= $TabContainer.get_child_count()

		
	if ntab < 0:
		ntab = $TabContainer.get_child_count()-1
	$TabContainer.current_tab = ntab
	selected()
	
func _physics_process(delta):
	if not is_visible_in_tree():return
	if Globals.remapping:return
	
	
	if Input.is_action_just_pressed("settings_left"):
		inc_tab(-1)
	if Input.is_action_just_pressed("settings_right"):
		inc_tab(1)
		


func _on_CheckBox_toggled(button_pressed):
	SavesManager.settings.igt = button_pressed
	SavesManager.settings.emit_signal("changed_setting")
	


func _on_OptionButton_item_selected(index):
	
	SavesManager.settings.controller_type = $TabContainer/Main/settings/OptionButton.get_item_id(index)
	SavesManager.settings.emit_signal("changed_setting")
	print(SavesManager.settings.controller_type)
	
