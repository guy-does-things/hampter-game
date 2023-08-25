extends "res://menu_cursor_handler.gd"

signal menu_exited()
var current_save_btn :SaveBtn= null


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 3:
		var save_fn = SavesManager.SAVE_DIR+str("/",i)+SavesManager.EXTENSION
		
		var result = SavesManager.load_save(save_fn)
		
		if result is Array:
			result = NewSaveData.new()
			result.save_path = save_fn
		
		
		get_child(i).focus_neighbour_left = get_child(i).get_path()
		get_child(i).focus_neighbour_right = get_child(i).get_path()
		
		get_child(i).initialize(result,save_fn)
		get_child(i).connect("save_sel",self,"save_sel")
		
	._ready()
	
func save_sel(saveb):
	current_save_btn = saveb
	if saveb.save and saveb.save.played:$Button2.disabled= false
	$Button3.disabled= false
	
		
	
func menu_shown():
	if is_instance_valid(last_thing_grabbed):
		last_thing_grabbed.grab_focus()
	else:
		$Button.grab_focus()


func _on_Button_pressed():
	emit_signal("menu_exited")
	hide()


func _on_Button2_pressed():
	$Panel4.show()
	$Panel4/HBoxContainer/Button2.grab_focus()

func cancel():
	$Panel4.hide()
	$Button.grab_focus()

func delete_save():
	$Panel4.hide()
	var ns = NewSaveData.new()
	ns.save_path = current_save_btn.save_path
	current_save_btn.initialize(ns,ns.save_path)
	SavesManager.save(current_save_btn.save)
	current_save_btn = null
	$Button2.disabled = true
	$Button3.disabled = true
	$Button.grab_focus()
	
	

func _on_Button3_pressed():
	if not current_save_btn.save.played:
		$Panel5.show()
		$Panel5/LineEdit.grab_focus()
	else:
		SavesManager.current_save = current_save_btn.save
		NewRoomAutoload.regenerate_room_save_data()
		yield(get_tree(),"idle_frame")
		get_tree().change_scene("res://new_world.tscn")
		




func save_done():
	SavesManager.current_save = current_save_btn.save
	SavesManager.current_save.name = $Panel5/LineEdit.text
	SavesManager.current_save.played = true
	SavesManager.save(SavesManager.current_save)
	NewRoomAutoload.regenerate_room_save_data()
	yield(get_tree(),"idle_frame")
	get_tree().change_scene("res://new_world.tscn")
	
	
	
	
