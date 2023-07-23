extends State

onready var t = $Timer
const MAX_DASHES = 3
var current_dashes = 0

func _enter_state(new,old):
	._enter_state(new,old)
	t.start()

func _exit_state(old,new):
	._enter_state(old,new)
	t.stop()
	
	if new.name != "Dash":
		entity.rotation_degrees = 0 
		$"%Flippables".disabled = false
		$"%Flippables".is_moving_y = false
		current_dashes = 0
	
	
	
	
	
func _state_logic(dt):
	$"%Flippables".disabled = false
	$"%Flippables".is_moving_y = true
	if t.time_left > .3:
		
		$"%Dash".dir = entity.global_position.direction_to($"%StatusThing".target.global_position)
		entity.look_at($"%StatusThing".target.global_position)
	

func _get_transition(dt):
	if current_dashes > MAX_DASHES:
		return $"%RandomAttacks"
	
	if t.is_stopped():
		return $"%Dash"
		current_dashes += 1
