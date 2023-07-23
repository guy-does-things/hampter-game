extends State


onready var t = $DashTime
export var charge_atspeed = 500
var dir : Vector2


func _enter_state(new,o):
	$"%Flippables".disabled = true
	._enter_state(new,o)
	$"%DashCollider".disabled = false
	t.start()

func _exit_state(o,n):
	$"%DashCollider".disabled = true
	._exit_state(o,n)
	#$"%Flippables".disabled = false
	

func _state_logic(dt):	
	#if state_machine.previous_state.name == "DashCharge" and t.time_left < .1:return
	
	entity.velocity = dir * charge_atspeed
	
	
func _get_transition(dt):
#	if state_machine.previous_state.name == "DashCharge":
#		if t.is_stopped():
#			return state_machine.previous_state
#
#
	if entity.get_slide_count() > 0:
		entity.dir = entity.get_slide_collision(0).normal
		return $"%HitWall"
		
		
			
