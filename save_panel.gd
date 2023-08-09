extends "res://menu_cursor_handler.gd"

signal menu_exited()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 3:
		var save_fn = SavesManager.SAVE_DIR+str("/",i)+SavesManager.EXTENSION
		
		var result = SavesManager.load_save(save_fn)
		
		if result is Array:result = null
		
		get_child(i).focus_neighbour_left = get_child(i).get_path()
		get_child(i).focus_neighbour_right = get_child(i).get_path()
		
		get_child(i).initialize(result)
		
	._ready()
	
func menu_shown():
	if is_instance_valid(last_thing_grabbed):
		last_thing_grabbed.grab_focus()
	else:
		$Button.grab_focus()


func _on_Button_pressed():
	emit_signal("menu_exited")
	hide()
