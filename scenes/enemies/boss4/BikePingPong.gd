extends FoxActionState


var current_bike : GdtBullet
var hits = 0
var seq_val = 0


var active = false
var can_exit = false
var is_animating_exit = false


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	yield(jump_towards(),"completed")
	
	yield($"%AnimationPlayer".play_anim("pickuprifle",2),"completed")
	active = true


func jump_towards():
	var d1  = ($"%StatusThing".target.global_position.x - MapManager.current_room_in.roomrect.get_global_rect().position.x)
	var d2  = ($"%StatusThing".target.global_position.x - MapManager.current_room_in.roomrect.get_global_rect().end.x)

	var used_pos = MapManager.current_room_in.roomrect.get_global_rect().position.x
	
	if abs(d2) > abs(d1):
		used_pos = MapManager.current_room_in.roomrect.get_global_rect().end.x


	var dist = (used_pos-entity.global_position.x)*3
			
	if abs(dist) > 180:

		entity.velocity.x = dist
		$"%Jumper".jump_force = -300
		$"%Jumper".jump()
		print_debug("??")
		yield($"%idle","landed")
		return
	yield(get_tree(),"idle_frame")
	

func _state_logic(delta):
	
	if not active:return
	
	
	
	if seq_val == 2 and not is_animating_exit:
		is_animating_exit = true
		yield($"%AnimationPlayer".play_anim("pickuprifle",2,true),"completed")
		can_exit = true

	
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
			


	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	reset_counters()
	$"%Halb".get_gun_data().data_res.no_cooldown = false
	$"%Flippables".disabled = false
	seq_val = 0
	active = false
	can_exit = false
	is_animating_exit = false



func _get_transition(delta):
	if seq_val==2 and can_exit:
		
		
		
		
		return state_machine.get_node(state_machine.initial_state)




func _on_BisexualGun_proj_created(proj):
	current_bike = proj
	yield(current_bike,"movement")
	current_bike.customdata.bikehand.connect("bullet_hit",self,"bike_collision")
	current_bike.connect("tree_exiting",self,"reset_counters")
	current_bike.customdata.bikehand.connect("wall_hit",self,"wall_hit")
	

func wall_hit():
	seq_val = 2

func reset_counters():
	hits = 0
	
	
func bike_collision(is_ene):
	
	if is_ene:
		hits+= 1
	
	if hits >= 2:
		seq_val = 1
		if is_instance_valid(current_bike):
			yield(current_bike,"tree_exited")

		
		
		seq_val = 2
		return

