extends Control

signal deselected()

func should_deselect():return true

func selected():
	show()
	print($TabContainer.current_tab)
	match $TabContainer.current_tab:
		0:
			$Button.focus_neighbour_top = $TabContainer/Main/settings/HSlider3.get_path()
			$TabContainer/Main/settings/HSlider.grab_focus()
		1:
			$Button.focus_neighbour_top = $TabContainer/Keyboard/settings.last_btp.btn.get_path()
			$Button.grab_focus()
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
		
