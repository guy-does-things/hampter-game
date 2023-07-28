tool
class_name nTransitionTrigger
extends CollisionShape2D


onready var space_state := get_world_2d().direct_space_state
export var normal_to_ignore : Vector2

var triggered = false
var room_to_load : PackedScene
var parameters := Physics2DShapeQueryParameters.new()



func set_room_to_load(rtl:PackedScene):
	room_to_load = rtl


# setup collision patterns
func _ready():
	do_thing()
		

	parameters.transform = global_transform
	# player only collisions are on the 7th layer
	parameters.collision_layer = 1<<7
	parameters.set_shape(shape)




func _physics_process(delta):
	modulate = Color("ff77a8")
	# draw editor gizmos
	# same here

	if Engine.editor_hint:return

	var result := space_state.get_rest_info(parameters)

	
	if result.empty():
		# makes it so it can actually do collisions again
		triggered = false
		return
	#print_debug(result.normal)
	# make it only work on initial enter to avoid
	# spawning 500000 DreadILLION rooms
	if triggered:
		return

	triggered = true
#	print_debug(result.normal, normal_to_ignore, room_to_load)

	if result.normal == normal_to_ignore:
		return

	if room_to_load == null:return
	
	NewRoomAutoload.load_room(
		NewRoomAutoload.get_data_from_packedscene(room_to_load)
	)

func do_thing():
	var trans_name = name.to_lower()
	if "bottom" in trans_name or "down" in trans_name:
		normal_to_ignore = Vector2.UP
	if "up" in trans_name or "top" in trans_name:
		normal_to_ignore = Vector2.DOWN
	if "left" in trans_name:
		normal_to_ignore = Vector2.RIGHT
	if "right" in trans_name:
		normal_to_ignore = Vector2.LEFT

