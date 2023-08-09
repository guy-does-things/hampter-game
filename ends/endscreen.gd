extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer2/VBoxContainer2/Label.text = str("playtime: ",Igt.FormatTime(Igt.gametime))
	$CanvasLayer2/VBoxContainer/Button.grab_focus()

func _on_Button_pressed():
	Globals.is_endgame = false
	get_tree().change_scene_to(load("res://titleroom.tscn"))
	
