extends State

export(Array,NodePath) var attacks :Array

func _ready():
	randomize()

func _get_transition(delta):
	var rindex =randi() % attacks.size()
	rindex = 3
	return get_node(attacks[rindex])
