extends VBoxContainer

signal deselected()

func selected():
	show()


func deselect():
	hide()
	emit_signal("deselected")


func _on_Button4_pressed():
	deselect()
