extends State

signal landed()

export var path_fallstate : NodePath
export var path_floorstate :NodePath
export var path_jumpstate : NodePath
export var path_slamstate : NodePath


onready var fallstate : State = get_node_or_null(path_fallstate)
onready var slamstate : State = get_node_or_null(path_slamstate)

onready var floorstate : State = get_node_or_null(path_floorstate)
onready var jumpstate : State = get_node_or_null(path_jumpstate)
export var is_walk_state : bool = false


func _enter_state(new_state, old_state):
	emit_signal("entered")
	
	if is_walk_state:return
	
	if old_state in [fallstate,jumpstate,slamstate]:
		emit_signal("landed")


func get_land_trans():

	if is_walk_state:
		return abs(entity.velocity.x) < 24
	return abs(entity.velocity.x) > 24
	

func _get_transition(delta):
	#print_debug(get_land_trans())

	if entity.velocity.y > 0 and !entity.is_on_floor():return fallstate
	if entity.velocity.y < 0 and !entity.is_on_floor():return jumpstate


	if get_land_trans():return floorstate
