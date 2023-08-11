extends State


var t = 0.0
var initial_p : Vector2
var targ = null
func initialize(en, statmach):
	.initialize(en, statmach)
	initial_p = en.global_position



func _state_logic(delta):
	targ = $"%StatusThing".target
	# interpolates to the player, is getting a node because testing
		
	var dir = entity.global_position.direction_to(initial_p)
	
	if sign(dir.y) == -1:
		entity.velocity.y += dir.y * 10 * rand_range(.5,1.2)
	
	
	t+= delta
	
	entity.scale = Vector2.ONE * 1.5
	if is_instance_valid(targ):
		initial_p.y = lerp(initial_p.y,targ.global_position.y,delta)
	

func _get_transition(delta):
	if !is_instance_valid(targ):return

	#if !targ.global_position.distance_to(entity.global_position) < 120:return
	
	var y_dist = floor(abs(targ.global_position.y -entity.global_position.y))

	
	if (y_dist > 16):return
	
	print(y_dist)
	return $"../LAUNCHEDAAAAAAA"
