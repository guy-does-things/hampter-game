extends FoxActionState


var slashes = 0

var can_slash = true
export var slash_move_speed = 450
var dir = 0
var active = false
var can_exit = false
var is_animating_exit = false




func _state_logic(dt):
	if not active:return
	
	if slashes <= 3:
		do_combo()
	elif not is_animating_exit:
		is_animating_exit = true
		yield($"%AnimationPlayer".play_anim("pickupswd",2,true),"completed")
		can_exit = true
		
	

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	$"%Flippables".disabled = true
	$"%Flippables".update_flip()
	dir = $"%Flippables".scale.x
	yield($"%AnimationPlayer".play_anim("pickupswd",2),"completed")
	active = true


func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	$"%Flippables".disabled = false
	slashes = 0
	can_exit = false
	is_animating_exit = false
	active = false


func _get_transition(dt):
	if slashes >= 3 and can_exit:
		return state_machine.get_node(state_machine.initial_state)





	
	
func do_combo():
	if $"%Halb".current_state != GdtGun.GunStates.IDLE or not entity.is_on_floor():return

	if not can_slash:return


	$"%Halb".stop_firing()
	$"%Halb".dir.x = dir
	$"%Halb".playerstatus = $"%StatusThing"
	# lying to the blade just so it lets the fox do a moving combo
	$"%Halb".is_idle = true
	$"%Halb".on_floor = true
	$"%Halb".try_shooting()
	
	entity.velocity.x = dir * slash_move_speed
	entity.velocity.y = -100
	slashes += 1
	#can_slash = false



func _on_Halb_postfired(gun):
	can_slash = true
