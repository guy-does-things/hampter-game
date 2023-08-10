extends VBoxContainer

signal deselected()

func selected():
	show()


func deselect():
	hide()


func _on_Button4_pressed():
	deselect()
	emit_signal("deselected")
