extends State


var did_anim = false
onready var idlestate : State = get_node(path_idlestate)
export var path_idlestate : NodePath


func _enter_state(new_state, old_state):
	
	._enter_state(new_state, old_state)
	did_anim = false
	

func _state_logic(dt):
	entity.velocity.y = 700
 

func _get_transition(delta):
	if entity.is_on_floor():return idlestate
