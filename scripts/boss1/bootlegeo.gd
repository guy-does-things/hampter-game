extends "res://scenes/introscorpion/enemy.gd"

var outline_colors =[
	Color.black,
	Color.white,
	Color.red,
	Color.orangered
	
]


export var o_color = 0.0 setget set_ocolor; func set_ocolor(val):
	if not is_inside_tree():return
	
	o_color = val
	$Flippables/Bootlegeo.material.set_shader_param("rep_col",outline_colors[int(o_color)%4])
	pass





