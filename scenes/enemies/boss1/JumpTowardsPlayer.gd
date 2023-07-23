extends State

onready var t = $Timer

var attack_state = 0
var dk_speed = 800


func _enter_state(n,o):
	
	._enter_state(n,o)
	if o == $"%Shoot":
		jump()
		

func _exit_state(o,n):
	._exit_state(o,n)
	t.stop()

	
func jump():
	$"%AnimationPlayer".play("jump")
	var jump_height = -400
	var distance = ($"%StatusThing".target.global_position.x - entity.global_position.x)*3.0
		
	entity.velocity = Vector2(distance,jump_height)
	attack_state = 1
	
func _state_logic(dt):
	if entity.is_on_floor() and attack_state == 0 :
		jump()



	if (entity.velocity.y > 0) and attack_state < 2 and t.is_stopped():
		var vel = entity.global_position.direction_to($"%StatusThing".target.global_position) * dk_speed
		t.start()
		yield(t,"timeout")
		if state_machine.state != self:return
		entity.velocity = vel
		
		
		attack_state = 2
		$"%AnimationPlayer".play("dropkick")



func _get_transition(dt):
#	if entity.is_on_floor():
#
	if entity.is_on_floor() and attack_state == 2:
		$"%AnimationPlayer".play("RESET")
		
		#entity.velocity *= 0
		attack_state = 0
		return $"%RandomAttacks"
	
	


func _on_Entity_lowhp():
	dk_speed = 900
	t.wait_time = .075
