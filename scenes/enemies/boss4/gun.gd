extends FoxActionState

export var max_shots = 0

var shots = 0
var can_fire = true

var active = false
var can_exit = false
var is_animating_exit = false

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	yield($"%AnimationPlayer".play_anim("pickupgun",2),"completed")
	active = true

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	shots = 0





func _state_logic(dt):
	if not active:return
	if shots >= max_shots:
		if not is_animating_exit:
			
			is_animating_exit = true
			yield($"%AnimationPlayer".play_anim("pickupgun",2,true),"completed")
			can_exit = true
			
		return
	fire()

func fire():
	if not can_fire:return
	can_fire = false
	$"%Twinkl".emitting = true
	yield(get_tree().create_timer(.3,false),"timeout")
	entity.o_color = 1
	yield(get_tree().create_timer(.1,false),"timeout")
	entity.o_color = 0
	
	
	$"%Glock".deal_with_dir(Vector2($"%Flippables".scale.x,0))
	$"%Glock".try_shooting()

	


func _get_transition(delta):
	if shots >= max_shots and can_exit:
		can_exit = false
		is_animating_exit = false
		active = false
		
		return state_machine.get_node(state_machine.initial_state)

func _on_Glock_fired(gun):
	shots += 1


func _on_Glock_postfired(gun):
	can_fire = true
	pass # Replace with function body.
