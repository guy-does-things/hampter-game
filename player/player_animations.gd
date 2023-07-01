extends AnimationPlayer



var can_anim = true

func play(name: String = "", custom_blend: float = -1, custom_speed: float = 1.0, from_end: bool = false):
	if !can_anim:return
	.play(name,custom_blend,custom_speed,from_end)
	
	

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




