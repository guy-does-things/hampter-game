extends State


var should_fly = false
var tp_state = 0

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	$Timer.start()

func _exit_state(old_state, new_state):
	._exit_state(old_state,new_state)
	should_fly = false
	$"%Flippables".disabled = false
	tp_state = 0

func _state_logic(delta):
	
	if not should_fly:return
	
	entity.velocity.y -= 5
	entity.velocity.x += 10


func _get_transition(dt):
	if tp_state==2:
		entity.velocity = Vector2.ZERO
		return $"%Rattacks"
	
	if entity.is_on_ceiling() and tp_state == 0:
		tp()
	


func tp():
	var st = entity.ripoffdraculateleport(self)
	tp_state = 1
	yield(st,"completed")
	tp_state = 2

func _on_Timer_timeout():
	should_fly = true
	entity.velocity.y = -300
