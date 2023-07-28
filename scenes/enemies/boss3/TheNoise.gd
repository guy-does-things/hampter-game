extends State


export var dist_from_floor_after_noise = 32
var needs_to_fire_up_noise = false
var bullet_scale_mult = 1
var big_shots = 0
var should_trans_out = false
var can_fire_noise = false
signal moving()

func _state_logic(delta):
	
	if should_trans_out:return
	#print_debug("whast")
	if can_fire_noise:
		fire_noise_shot()
	
	
	
func teleport():
	var rr= entity.get_roomr(true)

	var pos = Vector2(rr.get_center().x+8,entity.global_position.y)
	
	yield(entity.tp_to_pos(pos,self),"completed")


func _enter_state(new_state, old_state):
	
	._enter_state(new_state, old_state)
	bullet_scale_mult = 1
	$Timer.start()
	teleport()


func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	bullet_scale_mult = 1
	needs_to_fire_up_noise = false
	big_shots = 0
	should_trans_out = false
	can_fire_noise = false



func _get_transition(delta):
	if should_trans_out:
		return $"%NoiseDelay"

func _can_transition_to()-> bool:return true


func fire_noise_shot(soverride=false):
	
	$"%NoiseShot".deal_with_dir(Vector2($"%Flippables".scale.x,0))
	$"%NoiseShot".try_shooting()


func _on_NoiseShot_fired(gun):
	
	needs_to_fire_up_noise = !needs_to_fire_up_noise
	
	var rr= entity.get_roomr(true)
	yield(get_tree().create_timer(.1,false),"timeout")

	create_tween().tween_property(
		entity,
		"global_position:y",
		# -78 is the amount needed for the bat to get off
		# the floor
		(rr.end.y-78) - (dist_from_floor_after_noise if needs_to_fire_up_noise else 0)*bullet_scale_mult,
		.2
	)
	emit_signal("moving",needs_to_fire_up_noise)


func _on_NoiseShot_proj_created(proj):
	$"%Bat".frame = 5
	proj.customdata.chargablenoise = true
	proj.scale *= bullet_scale_mult
	
	if bullet_scale_mult != 2:return false
	big_shots += 1
	
	if big_shots >= 2:
		should_trans_out = true
		big_shots = 0
	
	

func _on_NoiseHolder_supercharged():
	if state_machine.state != self or should_trans_out:return
	
	bullet_scale_mult = 2


func _on_Timer_timeout():
	if state_machine.state != self:return
	
	can_fire_noise = true
