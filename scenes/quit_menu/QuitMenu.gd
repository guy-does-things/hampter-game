extends "res://menu_cursor_handler.gd"



func should_deselect():return true

func selected():
	show()
	$Deny.grab_focus()


func deselect():
	hide()




func _on_Quit_pressed():
	get_tree().paused = false
	Globals.can_open_menu =true
	get_tree().change_scene(
		"res://titleroom.tscn"
	)
