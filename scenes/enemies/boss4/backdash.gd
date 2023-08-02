extends FoxActionState


export var speed := 100
var landed = false




func _exit_state(o,n):
	._exit_state(o,n);landed=false

func _get_transition(delta):
	if landed:
		return state_machine.get_node(state_machine.initial_state)


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)

	var speedmult = -2 if $"%WallCast".is_colliding() else 1

	entity.velocity.x = -sign(entity.global_position.direction_to(
		$"%StatusThing".target.global_position
	).x) * speed *( speedmult)


	$"%Jumper".jump_force = -100 if speedmult == 1 else -400
	$"%Jumper".jump()
	

func _on_idle_landed():
	if state_machine.state == self:landed = true
	
