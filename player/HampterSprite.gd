tool
extends Sprite

var is_attacking : bool

export var main_frame : int setget set_mainf; func set_mainf(f):
	if is_attacking:return
	main_frame = f
	frame = main_frame
