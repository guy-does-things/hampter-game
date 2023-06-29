extends GdtGun


var current_attack = 0
export(Array,Resource) var hal_at_lookuptable







func try_shooting():
	if $AttackStateMachine.state != $AttackStateMachine/PogoStic:
		fire()
	
	

func _on_Node2D_postfired(gun):
	$DelayTimer.start()



func _on_Node2D_fired(gun):
	$DelayTimer.stop()
	$AudioStreamPlayer.play()
