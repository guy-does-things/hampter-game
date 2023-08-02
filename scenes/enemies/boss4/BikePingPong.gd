extends FoxActionState


var current_bike : GdtBullet
var hits = 0
var seq_val = 0

func _state_logic(delta):
	if seq_val != 0:return
	
	$"%BisexualGun".dir.x = $"%Flippables".scale.x
	# fires 
	if not is_instance_valid(current_bike):
		$"%Twinkl2".emitting = true
		seq_val = -1
		yield(get_tree().create_timer(.64,false),"timeout")
		entity.o_color = 1
		yield(get_tree().create_timer(.1,false),"timeout")
		entity.o_color = 0
		$"%BisexualGun".try_shooting()
		seq_val = 0
		return
	# does pingpong bullshit
	if current_bike.is_enemy:return
	
	var d = entity.global_position.distance_to(current_bike.global_position)
	
	if d < 128 and hits < 2:
		$"%Halb".get_gun_data().data_res.no_cooldown = true
		$"%Halb".is_idle = true
		$"%Halb".on_floor = true
		$"%Halb".try_shooting()
		$"%Halb".stop_firing()
			
		
func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)


	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	reset_counters()
	$"%Halb".get_gun_data().data_res.no_cooldown = false
	$"%Flippables".disabled = false
	seq_val = 0

func _get_transition(delta):
	if seq_val==2:
		return state_machine.get_node(state_machine.initial_state)




func _on_BisexualGun_proj_created(proj):
	current_bike = proj
	yield(current_bike,"movement")
	current_bike.customdata.bikehand.connect("bullet_hit",self,"bike_collision")
	current_bike.connect("tree_exiting",self,"reset_counters")

func reset_counters():
	hits = 0
	
	
func bike_collision(is_ene):
	
	if is_ene:
		hits+= 1
	
	if hits >= 2:
		seq_val = 1
		if is_instance_valid(current_bike):
			yield(current_bike,"tree_exited")
		yield(get_tree().create_timer(.6,false),"timeout")
		seq_val = 2
		return

