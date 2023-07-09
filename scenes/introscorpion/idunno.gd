extends State


export(NodePath) var idle_state_path;onready var idle_state = get_node(idle_state_path)
export(NodePath) var attack_state_path;onready var attack_state = get_node(attack_state_path)


var target : HurtComponent



func _get_transition(delta):
	
	if !is_instance_valid($"%StatusThing".target):
		return idle_state
	return attack_state


