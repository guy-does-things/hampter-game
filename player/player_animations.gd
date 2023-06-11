extends AnimationPlayer




func _on_idle_entered():
	play("idle")

func _on_walk_entered():
	play("walk")


func _on_fall_entered():
	play("thefall")


func _on_jump_entered():
	play("thejump")


func _on_WallSlide_entered():
	play("climb")


func _on_WallSlide_started_grace():
	play("thejump")
	pass # Replace with function body.
