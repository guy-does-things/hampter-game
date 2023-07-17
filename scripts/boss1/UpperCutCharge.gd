extends State



onready var t = $Timer
var finished = false



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

func _get_transition(delta):
	if finished:
		return $"%Shoryuken"




func _on_Timer_timeout():
	entity.o_color = 0
	finished = true
