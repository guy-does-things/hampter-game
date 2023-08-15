extends "res://menu_cursor_handler.gd"


export var is_kb = false
var last_btp = null


func _ready():
	
	for action in Settings.DEFAUT_CONTROLLER.keys():
		var btn = preload("res://remap_button/remap_button.tscn").instance()
		add_child(btn)
		btn.setup(action,is_kb)
		btn.setup_focus(last_btp)
		last_btp = btn
	
	last_btp.btn.focus_neighbour_bottom = $"%Button".get_path()
