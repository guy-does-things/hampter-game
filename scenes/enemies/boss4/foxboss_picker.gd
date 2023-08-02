extends State


export(NodePath) onready var fallback = get_node(fallback)

func initialize(en, statmach):
	.initialize(en, statmach)
	for child in get_children():
		if child is State:statmach.add_state(child)
	

func _get_transition(dt):
	if not $"%StatusThing".target:return null
	
	
	var valid_state = null
	
	
	for i in 10:
		var rindex = randi() % get_child_count()
		var child :FoxActionState = get_children()[rindex]
		
	
		
		
		if child.stamina_requirement <= $"%StatusThing".stamina:
			if child != state_machine.previous_state:
				$"%StatusThing".decrease_stamina(child.stamina_requirement)
				return child
			else:
				valid_state = child
				
				
	if valid_state:
		$"%StatusThing".decrease_stamina(valid_state.stamina_requirement)
		return valid_state
	
	return null
	
