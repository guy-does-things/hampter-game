# handles setting the item state to either deleted
# or a custom state
tool
class_name RoomObjectManager
extends Node2D

var assigned_room_data 



	

func has_var(o:Object,n:String):
	if not o:
		return false
	return n in o


func setup(data):
	assigned_room_data = data
	
	for i in range(get_children().size()):
		var kid :Node= get_child(i)
		if kid.has_method("setup_interaction_status") and has_var(kid, "room_data") and has_var(kid,"index"):
			# the true determines that it changed it's interaction status
			# due to save loading
			kid.index = i
			kid.room_data = assigned_room_data
			kid.setup_interaction_status(i,assigned_room_data.pickups.get(i,false),true)
				



func add_child_below_node(n,cn,lun=false):move_child(null,INF)
func move_child(node,p):print_debug("no.")
	
	


