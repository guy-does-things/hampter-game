extends StateMachine

signal restrict_movement()
signal resume_movement()
signal uppercut()


func ex_inputs(on_floor:bool):
	pogo(on_floor)
	uppercut(on_floor)
	sonicslash(on_floor)
	
	
func uppercut(on_floor:bool):
	if not (state == $None or state == $Uppercut):
		return

	if !on_floor or !(Input.is_action_pressed("up") and Input.is_action_pressed("attack")):
		set_state($None)
		return
	set_state($Uppercut)
		
		
func pogo(on_floor:bool):
	
	
	if not (state == $None or state == $PogoStic):
		return

	if on_floor or !Input.is_action_pressed("down"):
		set_state($None)
		return
		
	set_state($PogoStic)
	


func sonicslash(on_floor:bool):
	if not (state == $None or state == $SonicSlash):
		return

	if !on_floor or !Input.is_action_pressed("down"):
		set_state($None)
		return
		
	set_state($SonicSlash)

func _on_Node2D_fired(gun):
	if state == $Uppercut:
		emit_signal("uppercut")
	
	if state == $None:
		set_state($Attack1)
		#emit_signal("resume_movement")
	elif state == $Attack1:
		set_state($Attack2)
		emit_signal("restrict_movement")
	
	elif state == $Attack2:
		set_state($Attack3)
		emit_signal("restrict_movement")
	
	elif state == $Attack3:
		set_state($None)
		$"../DelayTimer".stop()
		yield(get_tree().create_timer(.2),"timeout")
		emit_signal("resume_movement")


func _on_DelayTimer_timeout():
	set_state($None)
	emit_signal("resume_movement")
