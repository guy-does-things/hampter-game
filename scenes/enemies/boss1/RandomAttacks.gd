extends State

export(Array,NodePath) var attacks :Array

func _ready():
	randomize()

func _get_transition(delta):
	var rindex =randi() % attacks.size()
	#print(rindex)
	rindex = 2
	return get_node(attacks[rindex])
