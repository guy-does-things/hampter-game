extends State

export(NodePath) onready var gun = get_node(gun) ;
export var is_desp = false
export var max_tps = 3
var tps = 0
var gonna_exit = false

func _state_logic(delta):
	if gonna_exit:return
	
	gun.deal_with_dir(Vector2($"%Flippables".scale.x,0))
	gun.try_shooting()
	


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	
	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	tps = 0
	gonna_exit = false
	#_on_FireSHot_postfired(null)

func _get_transition(delta):
	if tps >= max_tps:
		return $"%Rattacks"


func _can_transition_to()-> bool:
	return $"%StatusThing".current_hp <= ($"%StatusThing".MAX_HP *.25) or !is_desp


func _on_FireSHot_postfired(gun:GdtGun):
	yield(entity.ripoffdraculateleport(),"completed")
	if not gun:return
	
	if gun.current_state != GdtGun.GunStates.CUSTOMSTOP:return
	yield(get_tree().create_timer(.6,false),"timeout")
	if (tps + 1) > max_tps:
		gonna_exit = true
		yield(get_tree().create_timer(.2,false),"timeout")
		
	gun.custom_state_reset()
	tps += 1
	
