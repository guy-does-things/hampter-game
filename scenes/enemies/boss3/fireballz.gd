extends State

export(NodePath) onready var gun = get_node(gun) ;
export var is_desp = false
export var max_tps = 3
var tps = 0
var gonna_exit = false
var cfire = false
func _state_logic(delta):
	if gonna_exit or !cfire:return
	
	gun.deal_with_dir(Vector2($"%Flippables".scale.x,0))
	gun.try_shooting()
	


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	
	cfire = false
	yield(entity.ripoffdraculateleport(self,"_enter_state"),"completed")
	cfire = true
	
	
func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	tps = 0
	gonna_exit = false


func _get_transition(delta):
	if tps >= max_tps and gonna_exit:
		return $"%Rattacks"


func _can_transition_to()-> bool:
	return $"%StatusThing".current_hp <= ($"%StatusThing".MAX_HP *.25) or !is_desp


func _on_FireSHot_postfired(gun:GdtGun):
	yield(entity.ripoffdraculateleport(self,"_on_FireSHot_postfired"),"completed")
	
	if not gun:return
	
	if gun.current_state != GdtGun.GunStates.CUSTOMSTOP:return
	if (tps + 1) > max_tps:
		gonna_exit = true
		
	yield(get_tree().create_timer(.45,false),"timeout")
	gun.custom_state_reset()
	tps += 1
	
