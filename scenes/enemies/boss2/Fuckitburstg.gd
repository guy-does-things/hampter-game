extends State


var max_bursts = 5
var bursts = 0
var firing = false

var act = false
var can_e = false

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	bursts = 0
	can_e = false
	$"../../AnimationPlayer".play("pgunout")
	
	yield($"../../AnimationPlayer","animation_finished")
	
	act = true
	

func _state_logic(dt):
	
	if not act or bursts >= max_bursts:return
	if not firing:
		entity.look_at($"%StatusThing".target.global_position)
		$"%Flippables".is_moving_y = true

	try_f()

func try_f():
	if firing:return
	firing = true
	$"%BisexualGun".deal_with_dir(entity.global_position.direction_to($"%StatusThing".target.global_position))
	$"%Twinkl3".emitting = true
	yield(get_tree().create_timer(.5,false),"timeout")
	$"%Twinkl3".emitting = false
	
	$"%BisexualGun".try_shooting()
	return true
	

func _get_transition(dt):
	if bursts >= max_bursts and can_e:
		return $"%RandomAttacks"


func _on_BisexualGun_postfired(gun):
	bursts += 1
	firing = false
	$"%BisexualGun".stop_firing()
	if bursts >= max_bursts:
		$"../../AnimationPlayer".play_backwards("pgunout")
		yield($"../../AnimationPlayer","animation_finished")
		can_e = true
