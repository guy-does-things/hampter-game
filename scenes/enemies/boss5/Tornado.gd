extends State

export var speed = 5
export var max_t = 0.0
export var max_state_t = 0.0

var dir : float
var t = 0
var state_t = 0

var lfac = 0.0
var can_exit = false

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	$"%AnimationPlayer".stop()
	$"%AnimationPlayer".play_anim("speeen",3)
	$"%CPUParticles2D".emitting = true
	$"%ToR N A D O".monitoring = true
	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	$"%CPUParticles2D".emitting = false
	$"%AnimationPlayer".stop()
	$"%AnimationPlayer".play("idle")
	state_t = 0
	$"%ToR N A D O".monitoring = false
	can_exit = false



func _get_transition(dt):
	if state_t >= max_state_t and can_exit:
		return state_machine.get_node(state_machine.initial_state)


func _state_logic(delta):
	if state_t >= max_state_t and $"%CPUParticles2D".emitting:
		$"%CPUParticles2D".emitting = false
		
		$"%ToR N A D O".monitoring = false
		yield(get_tree().create_timer(1,false),"timeout")
		$"%AnimationPlayer".play("idle")
		can_exit = true
		return
	
	entity.velocity.x += (dir * speed) 
	state_t += delta
	
	if t >= max_t:
		
		dir = lerp(dir,entity.global_position.direction_to($"%StatusThing".target.global_position).x,lfac)
		lfac = min(1,lfac+delta)
		if lfac == 1:
			t = 0
			lfac = 0
	else:
		t += delta
