class_name DirComp
extends Node


var last_dir : Vector2
var current_dir : Vector2


var lstr = "left"
var rstr = "right"
var ustr = "up"
var dstr = "down"

var can_get_dir = true

func __get_dir()-> Vector2:
	return Vector2(
			(Input.get_action_strength(rstr) - Input.get_action_strength(lstr)), 
			(Input.get_action_strength(dstr) - Input.get_action_strength(ustr)) 
	)
	

func _process(delta):
	if not can_get_dir:return
	
	current_dir = __get_dir()
	
	if current_dir != Vector2.ZERO:
		last_dir = current_dir


func dir_wait(t):
	can_get_dir = false
	yield(get_tree().create_timer(t),"timeout")
	can_get_dir = true
