extends "res://scenes/enemies/introscorpion/enemy.gd"

func on_spawned():
	$StateMachine/Intro.can_transition = true
	
	
func _process(dt):
	if Input.is_key_pressed(KEY_L):
		on_spawned()



