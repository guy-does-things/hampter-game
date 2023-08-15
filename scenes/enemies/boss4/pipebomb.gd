extends FoxActionState




var active = false
var can_exit = false
var bomb_thrown = false
func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)	
	active = false
	yield($"%AnimationPlayer".play_anim("pickupbomb",2),"completed")
	$"%Twinkl3".emitting = true
	yield(get_tree().create_timer(.3,false),"timeout")
	entity.o_color = 1
	yield(get_tree().create_timer(.1,false),"timeout")
	entity.o_color = 0
	
	
	active = true
	yield(jump(),"completed")
	can_exit = true



func jump():
	var d1  = (entity.global_position.x - MapManager.current_room_in.roomrect.get_global_rect().position.x)
	var d2  = (entity.global_position.x - MapManager.current_room_in.roomrect.get_global_rect().end.x)

	var used_pos = MapManager.current_room_in.roomrect.get_global_rect().position.x	
	
	if abs(d2) > abs(d1):
		used_pos = MapManager.current_room_in.roomrect.get_global_rect().end.x

	var dist = (used_pos-entity.global_position.x)*3
			
	if abs(dist) > 180:
		entity.velocity.x = dist
		$"%Jumper".jump_force = -450
		$"%Jumper".jump()
		yield($"%idle","landed")
		return
	yield(get_tree(),"idle_frame")





func _get_transition(dt):
	if can_exit:
		$"%PipeBomb".scale *= 0
		active = false
		can_exit = false
		bomb_thrown = false
		return state_machine.get_node(state_machine.initial_state)
	
	


func _state_logic(dt):
	if not active:
		return
	
	


	var distance = ($"%StatusThing".target.global_position.x - entity.global_position.x)
	if abs(distance) < 32 and not bomb_thrown:
		$"%PipeBomb".try_shooting()
		bomb_thrown = true


		



func _on_PipeBomb_proj_created(proj):
	$"%PipeBomb".scale *= 0
