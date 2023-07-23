extends State



onready var t = $Timer
var finished = false
var is_phase2 = false


func _enter_state(new,old):
	._enter_state(new,old)
	t.start()

func _exit_state(old,new):
	._exit_state(old,new)
	t.stop()
	finished = false
	

func _state_logic(delta):
	entity.velocity.x = 0
	if !finished:entity.o_color += .25
	if t.time_left < .2:
		entity.o_color = 0

func _get_transition(delta):
	var distance = ($"%StatusThing".target.global_position.x - entity.global_position.x)
	
	if abs(distance) > 64 and (is_phase2 and t.time_left > .2):
		t.stop()
		entity.o_color = 0
		return $"%RunTowardsPlayer"
	
	
	if finished:
		return $"%Shoryuken"




func _on_Timer_timeout():
	#entity.o_color = 0
	finished = true


func _on_Entity_lowhp():
	is_phase2 = true
