class_name ActionState
extends State

export(NodePath) onready var hbshape = get_node(hbshape)
var space_state :Physics2DDirectSpaceState

var hinfo = HitInfo.new()
enum CheckValues{
	FAILED,
	SUCCESS_NOTRANS,
	SUCCESS_TRANS
}

class HitInfo:
	var hitbox:Shape
	var vel:Vector2
	var transf:Transform2D
	var frame : int

	func duplicate():
		var s = HitInfo.new()
		s.hitbox = hitbox
		s.transf = transf
		s.vel = vel
		
		return s

func initialize(en, statmach):
	.initialize(en, statmach)
	for state in get_children():
		state_machine.add_state(state)




func action_check(dt):
	space_state = entity.get_world_2d().direct_space_state


func do_action(dt):pass



	
func hit_test(
	shape:Shape2D,
	trans:Transform2D,
	vel:Vector2,
	start_tick=0,
	ticks=8,
	exclude=[]
):
	var ntestparms :=Physics2DShapeQueryParameters.new()
	if (shape==null):return {}
	
	for i in ticks:
		var ticktrans = trans
		
		ticktrans.origin += (vel * (i+start_tick) )
		ntestparms.exclude = get_tree().get_nodes_in_group("player")
		ntestparms.collide_with_areas = true
		ntestparms.collision_layer = 512
		ntestparms.set_shape(shape)
		ntestparms.transform = ticktrans
		ntestparms.motion = vel
		
		var res = space_state.get_rest_info(ntestparms)
		if !res.empty():
			if instance_from_id(res.collider_id) == hbshape.get_parent():
				res.tickhit = i
				return res
			
	return {}
