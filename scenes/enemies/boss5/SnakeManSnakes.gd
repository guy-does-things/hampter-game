extends State

var bursts = 0
export var max_bursts = 3
export(NodePath) onready var gun = get_node(gun)


func _ready():
	(gun as GdtGun).connect("postfired",self,"_on_gun_postfired")
	(gun as GdtGun).connect("fullypoweredup",self,"_on_gun_fullypoweredup")


func _state_logic(dt):
	gun.try_shooting()



func _on_gun_postfired(gun):
	bursts += 1

func _on_gun_fullypoweredup(gun):
	gun.dir.x = $"%Flippables".scale.x
	gun.stop_firing()

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)		
	bursts = 0
	gun.stop_firing()

func _get_transition(dt):
	if bursts >= max_bursts:
		return state_machine.get_node(state_machine.initial_state)
	
	

	
