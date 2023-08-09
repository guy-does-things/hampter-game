extends Control

signal deselected()

func selected():
	show()
	match $TabContainer.current_tab:
		0:
			$TabContainer/Main/settings/HSlider.grab_focus()
			$Button.focus_neighbour_top = $TabContainer/Main/settings/HSlider3.get_path()
	


func deselect():
	hide()
	emit_signal("deselected")
	

func _on_Button_pressed():
	deselect()
