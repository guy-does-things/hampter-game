extends State

export(Array,NodePath) var attacks :Array


func _get_transition(delta):
	var rindex =randi() % attacks.size()
	return get_node(attacks[rindex])
