extends State

var ready_to_attack = false
var attacks_done = 0

func _state_logic(dt):
	
	if attacks_done >= 4:
		return
	
	if !ready_to_attack:
		entity.o_color += .25
	else:
		entity.o_color = 0
	
	if not ready_to_attack:
		
		$"%Flippables".is_moving_y = true
		
		entity.look_at($"%StatusThing".target.global_position)
		$"%SpitGun".deal_with_dir(Vector2.RIGHT.rotated(entity.global_rotation))
		$"%SpitGun".try_shooting()


func _get_transition(dt):
	
	if attacks_done >= 4:
		return $"%RandomAttacks"

func _exit_state(o,n):
	._exit_state(o,n)


	entity.rotation_degrees = 0
	$"%Flippables".is_moving_y = false
	$"%Flippables".disabled = false
	entity.o_color = 0
	ready_to_attack = false
	attacks_done = 0
	$"%SpitGun".stop_firing()

func _on_Entity_is_gonna_fire():
	ready_to_attack = true
	


func _on_SpitGun_postfired(gun):
	ready_to_attack = false
	attacks_done += 1
