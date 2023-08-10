extends "res://scenes/enemies/boss5/snakeshoot.gd"



func animate():
	yield($"%AnimationPlayer".play_anim("pickupthing",1),"completed")
	$"%AnimationPlayer".play_anim("snake_vase",3)
	is_active = true
	
	
	
func stop_anim():
	$"%AnimationPlayer".stop()
