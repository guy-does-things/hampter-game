extends "res://scenes/enemies/introscorpion/enemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _on_Area2D2_out_of_water(s="whatthefuck"):
	
	$"%StateMachine".set_state($"%OuTOFWATER")
	$"%PhysicsStuff".gravity_enabled = true


func _on_Area2D2_on_water(water):
	if $"%StateMachine".state == $"%OuTOFWATER":
		$"%StateMachine".set_state($StateMachine/idunno)
	
	$"%PhysicsStuff".gravity_enabled = false


func boom(dam):
	var expl = preload("res://bullets/explosion/explosion.tscn").instance()
	expl.global_position = global_position
	expl.lifetime = .55
	expl.damage = 0
	get_tree().current_scene.add_child(expl)
	queue_free()


