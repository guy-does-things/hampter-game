extends State

export var path_idlestate : NodePath
export var path_walk_state : NodePath
export var path_air_state : NodePath
export var path_wslide : NodePath



onready var idlestate : State = get_node(path_idlestate)
onready var walk_state : State = get_node(path_walk_state)
onready var air_state : State = get_node(path_air_state)
export var is_fall_state : bool = false


signal start_coyote_time()

func get_air_trans():
	if is_fall_state:
		return entity.velocity.y < 0 and !entity.is_on_floor()
		
	return entity.velocity.y > 0 and !entity.is_on_floor()

func _enter_state(new_state, old_state):
	emit_signal("entered")
	if is_fall_state and old_state in [idlestate, walk_state]:
		emit_signal("start_coyote_time")
		
	

	

func _get_transition(delta):
	if entity.is_on_floor():return idlestate
	if get_air_trans():return air_state
	
