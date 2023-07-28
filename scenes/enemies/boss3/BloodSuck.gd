extends State

signal started_dash()

var is_tping = false
var exit_mode = 3

var teleport_position : Vector2
const MAX_DIST = 608



func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	exit_mode = 3
	yield(teleport(),"completed")
	$Timer.start()
	
	
	


func _state_logic(delta):
	if exit_mode == 0:
		$"%Flippables".disabled = true
		$"%Flippables".flip(1)
		
		entity.velocity.x = 400
		


		
		if entity.global_position.distance_to(teleport_position) > MAX_DIST:
			is_tping =false
			exit_mode = 1


func _get_transition(delta):
	match exit_mode:
		1:return $"%Intro"
		2:return $"%DashFly"
		

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	exit_mode = 0
	is_tping = false
	if new_state.name == "DashFly":return
	
	$"%SuckDetector".monitoring = false
	$"%Flippables".disabled = false
	
	
	
	
	
func teleport():
	if is_tping:return
	
	is_tping = true
	var thing = entity.teleport_to_side(true,self)
	if thing is GDScriptFunctionState:
		yield(thing,"completed")
	
	teleport_position = entity.global_position


func _on_Area2D_body_entered(body):
	if state_machine.state == self:
		exit_mode = 2


func _on_Timer_timeout():
	if state_machine.state != self:return
	emit_signal("started_dash")
	exit_mode = 0
	$"%SuckDetector".monitoring = true
