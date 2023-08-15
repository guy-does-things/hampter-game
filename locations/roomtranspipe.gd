tool
class_name RoomTransPipe
extends Pipe

export(NodePath) var room_a
export(NodePath) var room_b

var room_to_load_a := {}
var room_to_load_b := {}





func on_riding(plr,index,movedir):
	
	var finalpointindex = points.size()-1
	var indexincrease = -1
	
	if movedir == -1:
		finalpointindex=0
		indexincrease = 1
		NewRoomAutoload.load_room(room_to_load_a)
	else:
		NewRoomAutoload.load_room(room_to_load_b)
		
		
	
	var finalpoint = to_global(points[finalpointindex])
	
	player = null
	plr.end_moving_on_tube()
	cooldown.start()
	var tubedir = points[finalpointindex+indexincrease].direction_to(finalpoint) 
	print(finalpointindex)
	(plr.get_node("DirComp") as DirComp).current_dir = tubedir
	
	plr.global_position = finalpoint +(tubedir* 32)
	moveindex = INF
	
	#yield(get_tree(),"idle_frame")
	(plr.get_node("DirComp") as DirComp).current_dir = Vector2.ZERO
	(plr.get_node("DirComp") as DirComp).dir_wait(.15)
	
