extends State


signal reachedtop
var hits = 0
var is_on_top = false



func _state_logic(delta):
	if hits >= 2:
		$"%SuckHitbox".monitoring = false
#		$"%StatusThing".target.entity.velocity.y = 900
#		$"%StatusThing".target.entity.velocity.x = $"%Flippables".scale.x * 600
		return
		
	if entity.is_on_ceiling() and not is_on_top:
		$"%SuckHitbox".monitoring = true
		emit_signal("reachedtop")
		$"%StatusThing".target.entity.hide()
		is_on_top = false
	entity.velocity.y -= 10
	
	
	$"%StatusThing".target.entity.global_position = entity.global_position if entity.is_on_ceiling() else $"%PositionA".global_position
	

func _get_transition(dt):
	if hits >= 2 or ($"%StatusThing".target as HurtComponent).entitystatus.current_hp <= 0:
		entity.velocity.y = 400
		
		$"%StatusThing".target.entity.show()
		return $"%SuckDownDelay"


func _enter_state(new_state, old_state):
	._enter_state(new_state,old_state)
	
	
	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	$"%SuckHitbox".monitoring = false
	$"%StatusThing".target.entity.show()
	hits = 0
	


func _on_SuckHitbox_actually_hit(enemy):
	hits += 1
	$"%StatusThing".current_hp += 10
