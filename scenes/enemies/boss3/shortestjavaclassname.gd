extends State


var hits = 0



func _state_logic(delta):
	if hits >= 2:
		$"%SuckHitbox".monitoring = false
#		$"%StatusThing".target.entity.velocity.y = 900
#		$"%StatusThing".target.entity.velocity.x = $"%Flippables".scale.x * 600
		return
		
	if entity.is_on_ceiling():$"%SuckHitbox".monitoring = true
	
	entity.velocity.y -= 10
	$"%StatusThing".target.entity.global_position = entity.global_position

	

func _get_transition(dt):
	if hits >= 2 or ($"%StatusThing".target as HurtComponent).entitystatus.current_hp <= 0:
		entity.velocity.y = 400
		return $"%SuckDownDelay"


func _enter_state(new_state, old_state):
	._enter_state(new_state,old_state)
	
	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	$"%SuckHitbox".monitoring = false
	hits = 0
	


func _on_SuckHitbox_actually_hit(enemy):
	hits += 1
	$"%StatusThing".current_hp += 10
