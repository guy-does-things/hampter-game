extends State

var bursts = 0
export var max_bursts = 3
export(NodePath) onready var gun = get_node(gun)
var is_active = false


func _ready():
	(gun as GdtGun).connect("postfired",self,"_on_gun_postfired")
	(gun as GdtGun).connect("fullypoweredup",self,"_on_gun_fullypoweredup")


func _state_logic(dt):
	if is_active:gun.try_shooting()

func animate():
	yield($"%AnimationPlayer".play_anim("pickupthing",1),"completed")
	$"%AnimationPlayer".play_anim("snake_vase",3)
	is_active = true
	
	
	
func stop_anim():
	$"%AnimationPlayer".stop()



func _on_gun_postfired(gun):
	bursts += 1

func _on_gun_fullypoweredup(gun):
	gun.dir.x = $"%Flippables".scale.x
	gun.stop_firing()

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)		
	bursts = 0
	gun.current_charge = 0
	is_active = false
	

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	bursts = 0 	
	animate()


func _get_transition(dt):
	print(bursts,max_bursts)
	
	if bursts >= max_bursts:
		stop_anim()
		return $"%Stun"
	

	
