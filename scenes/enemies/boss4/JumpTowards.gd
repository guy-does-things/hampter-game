extends FoxActionState





var landed = false
var jumped = false

func _exit_state(o,n):
	._exit_state(o,n);landed=false;jumped=false


	
func jump():
	$"%AnimationPlayer".play("jump")
	
	var distance = ($"%StatusThing".target.global_position.x - entity.global_position.x)*3.0
		
	entity.velocity.x = distance
	$"%Jumper".jump_force = -400
	$"%Jumper".jump()
	
	jumped= true

func _state_logic(delta):
	if entity.is_on_floor() and not jumped:
		jump()

func _get_transition(delta):
	if landed:
		
		return state_machine.get_node(state_machine.initial_state)


func _on_idle_landed():
	if state_machine.state == self:
		landed = true
