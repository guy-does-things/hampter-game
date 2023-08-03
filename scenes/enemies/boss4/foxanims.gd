extends AnimationPlayer

var apriority = 0

func play_anim(aname:String,prior:int,is_backwards=false):
	if prior > apriority:
		apriority = prior
		
		if is_backwards:play_backwards(aname)
		else:play(aname)
		
		yield(self,"animation_finished")
		apriority = 0
		return
		
	yield(get_tree(),"idle_frame")
	
	
	
func stop(reset=true):
	.stop(reset)
	apriority = 0

func _on_jump_entered():
	play_anim("jump",1)


func _on_fall_entered():
	play_anim("fall",1)


func _on_idle_entered():
	play_anim("idle",1)


func _on_BackDash_entered():
	play_anim("backdash",1)


func _on_BackDash_exited():
	stop()


func _on_Entity_entered_hitstun():
	if !get_parent().is_on_floor():
		play_anim("hurtair",8)
		return
	play_anim("hurtfloor",9)


func _on_idle_landed():
	if current_animation == "hurtair":
		play_anim("hurtfloor",9)


func _on_Tired_entered():
	play_anim("tired",10)
	



func _on_Entity_recharged():
	stop()





func _on_WalkTowards_entered():
	play_anim("run",1)


func _on_WalkTowards_exited():
	stop()
