extends State


export(NodePath) var think_state_path;onready var think_state = get_node(think_state_path)


export var dist_to_flip = 50.0
export var speed = 10
var initial_position :Vector2
var dirx = -1


func initialize(en, statmach):
	.initialize(en, statmach)
	initial_position = entity.global_position
	

func _state_logic(dt):
	
	if (
		entity.global_position.distance_to(initial_position) > dist_to_flip and 
		sign(initial_position.direction_to(entity.global_position).x) == dirx or
		$"%RayCast2D".get_collider() == null
	):
		dirx *= -1
		$"%RayCast2D".cast_to.x = dirx *50
		$"%RayCast2D".cast_to.y = 50
	
	$"%Flippables".flip(dirx)
	entity.velocity.x += dirx * speed
	#entity.global_position = initial_position


func _get_transition(delta):
	if $"%StatusThing".target:
		return think_state
