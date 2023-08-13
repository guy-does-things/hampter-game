extends Node2D




	


func _physics_process(delta):
	$"%Gun".deal_with_dir(Vector2.LEFT.rotated(global_rotation))
	$"%Gun".try_shooting()


func _on_Node2D_proj_created(proj):
	proj.rotation = global_rotation
	proj.scale.x = -1


func _on_Gun_fullypoweredup(gun):
	$"%Gun".stop_firing()
	pass # Replace with function body.


func _on_Gun_fired(gun):
	$Gun/AudioStreamPlayer.play()
