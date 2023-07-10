extends "res://menu_cursor_handler.gd"

func selected():
	show()
	$Button2.grab_focus()


func deselect():
	hide()


func _on_Button_pressed():
	get_tree().quit()
