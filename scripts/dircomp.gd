class_name DirComp
extends Node


var last_dir : Vector2
var current_dir : Vector2


var lstr = "left"
var rstr = "right"
var ustr = "up"
var dstr = "down"

func __get_dir()-> Vector2:
	return Vector2(
			(Input.get_action_strength(rstr) - Input.get_action_strength(lstr)), 
			(Input.get_action_strength(dstr) - Input.get_action_strength(ustr)) 
	)
	

func _process(delta):
	current_dir = __get_dir()
	
	if current_dir != Vector2.ZERO:
		last_dir = current_dir
