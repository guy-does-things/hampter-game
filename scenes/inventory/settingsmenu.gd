extends Control


func selected():
	show()
	match $TabContainer.current_tab:
		0:
			$TabContainer/Main/settings/HSlider.grab_focus()

	


func deselect():
	hide()
