extends StateMachine

signal restrict_movement()
signal resume_movement()
signal uppercut()
signal stop_ALL_movement()


var wof = false

	



func _on_DelayTimer_timeout():
	set_state($None)
	emit_signal("resume_movement")


func stop_movement():
	emit_signal("restrict_movement")


func _on_Uppercut_entered():
	emit_signal("stop_ALL_movement")
	pass # Replace with function body.




func _on_idle_landed():
	set_state($None)
	$"../HitBoxes/SpinSlash".monitoring = false



	
