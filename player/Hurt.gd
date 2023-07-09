extends State

export(NodePath) var idle_state_path; onready var idle_state = get_node(idle_state_path)
onready var tmer = $Timer


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	tmer.start()

func _get_transition(delta):
	if tmer.is_stopped() and entity.is_on_floor():
		return idle_state
