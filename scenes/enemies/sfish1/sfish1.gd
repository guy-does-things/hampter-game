extends "res://scenes/enemies/introscorpion/enemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _on_Area2D2_out_of_water(s="whatthefuck"):
	print("fucking what")
	
	$"%StateMachine".set_state($"%OuTOFWATER")
	$"%PhysicsStuff".gravity_enabled = true


func _on_Area2D2_on_water(water):
	if $"%StateMachine".state == $"%OuTOFWATER":
		$"%StateMachine".set_state($StateMachine/idunno)
	
	$"%PhysicsStuff".gravity_enabled = false
