extends "res://menu_cursor_handler.gd"


func selected():
	show()
	$Deny.grab_focus()


func deselect():
	hide()




func _on_Quit_pressed():
	get_tree().quit()