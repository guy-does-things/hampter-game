extends State


var should_fly = false

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	$Timer.start()

func _exit_state(old_state, new_state):
	._exit_state(old_state,new_state)
	should_fly = false
	
	$"%Flippables".disabled = false


func _state_logic(delta):
	
	if not should_fly:return
	
	entity.velocity.y -= 5
	entity.velocity.x += 10


func _get_transition(dt):
	if entity.is_on_ceiling():
		entity.velocity = Vector2.ZERO
		var st = entity.ripoffdraculateleport()
		yield(st,"completed")
		
		return $"%Intro"




func _on_Timer_timeout():
	should_fly = true
	entity.velocity.y = -300
