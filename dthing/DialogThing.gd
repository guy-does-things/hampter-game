extends CanvasLayer



	
	
var current_dialog :DialogThing


onready var yes = $Panel/VBoxContainer/yes
onready var no = $Panel/VBoxContainer/no

signal finished(yesbutton)

func setup_d_sequence(next_seq:DialogThing,is_yes=false):
	pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = true
	current_dialog = next_seq
	if next_seq == null:
		emit_signal("finished",is_yes)
		get_tree().paused = false
		hide()
		Globals.can_open_menu = true
		return
	show()
	Globals.can_open_menu = false
	
	yes.visible = current_dialog.buttons & 1 != 0
	yes.text = current_dialog.button_yes_text
	$Panel/VBoxContainer/Label.text = current_dialog.text	
	
	
	
	
	no.visible = current_dialog.buttons & 2 != 0
	no.text = current_dialog.button_no_text
	
	yes.grab_focus()
	if not yes.visible:
		no.grab_focus()
	
	
	
	
	

	
	
	
	


func _on_no_pressed():
	setup_d_sequence(current_dialog.no_continuation,false)


func _on_yes_pressed():
	setup_d_sequence(current_dialog.yes_continuation,true)
