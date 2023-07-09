extends State

signal jump()

var last_thing_hit :HurtComponent

func _on_SpinSlash_actually_hit(enemy):
	last_thing_hit = enemy

func _on_SpinSlash_timer_finished():
	last_thing_hit = null


func _on_SpinSlash_disabled():
	if is_instance_valid(last_thing_hit):
		#Hitfreeze.hitstop(.25)
		emit_signal("jump")
