extends FoxActionState

export var max_shots = 0

var shots = 0
var can_fire = true

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	shots = 0


func _state_logic(dt):
	if shots >= max_shots:return
	fire()

func fire():
	if not can_fire:return
	can_fire = false
	$"%Twinkl".emitting = true
	yield(get_tree().create_timer(.61,false),"timeout")
	entity.o_color = 1
	yield(get_tree().create_timer(.1,false),"timeout")
	entity.o_color = 0
	
	
	$"%Glock".deal_with_dir(Vector2($"%Flippables".scale.x,0))
	$"%Glock".try_shooting()

	


func _get_transition(delta):
	if shots >= max_shots:
		return state_machine.get_node(state_machine.initial_state)

func _on_Glock_fired(gun):
	shots += 1


func _on_Glock_postfired(gun):
	can_fire = true
	pass # Replace with function body.
