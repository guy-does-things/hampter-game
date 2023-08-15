extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	NewRoomAutoload.data_stack = []
	NewRoomAutoload.room_stack = []
	
	$CanvasLayer2/VBoxContainer2/Label.text = str("playtime: ",Igt.FormatTime(Igt.gametime))
	$CanvasLayer2/VBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	Globals.is_endgame = false
	get_tree().change_scene_to(load("res://titleroom.tscn"))
	


func _on_Button2_pressed():
	var ig = Igt.gametime
	SavesManager.current_save = SavesManager.load_save(SavesManager.current_save.save_path)
	SavesManager.current_save.igt = ig
	get_tree().change_scene_to(load("res://new_world.tscn"))
	
	
	
	
