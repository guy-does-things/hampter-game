tool
class_name RoomTransPipe
extends Pipe

var extra_cam_rect : Rect2 = Rect2(Vector2.ZERO,Vector2(-INF,-INF))

export(NodePath) var room_a
export(NodePath) var room_b

func _ready():
	var refr = ColorRect.new()
	refr.color = Color(0,0,1)
	refr.hide()
	add_child(refr)

	if points.size() <= 1:return
	refr.rect_size = Vector2.ONE * 32
	refr.rect_position = points[0]
	
	var rect = refr.get_rect()

	for point in points:
		rect = rect.expand(point)
		
	refr.rect_size = rect.size
	refr.rect_global_position = rect.position
	
	extra_cam_rect = refr.get_global_rect()
	refr.queue_free()
	
#
func on_riding(plr,index,movedir):
	
	var finalpointindex = points.size()-1
	var indexincrease = -1
	
	if movedir == -1:
		finalpointindex=0
		indexincrease = 1
	
	var finalpoint = to_global(points[finalpointindex])
	
	player = null
	plr.end_moving_on_tube()
	cooldown.start()
	var tubedir = points[finalpointindex+indexincrease].direction_to(finalpoint) 
	(plr.get_node("DirComp") as DirComp).current_dir = tubedir
	
	plr.global_position = finalpoint +(tubedir* 32)
	moveindex = INF
	
	#yield(get_tree(),"idle_frame")
	(plr.get_node("DirComp") as DirComp).current_dir = Vector2.ZERO
	(plr.get_node("DirComp") as DirComp).dir_wait(.15)
	
	
#
#	var c :RoomBasedCamera= plr.get_node("Camera2D")	
##
##	if extra_cam_rect.size.x == -INF:return
#	var rect := c.current_room_rect.merge(extra_cam_rect)
#	c.transition(rect)
#
#
	
#var shootdir = player.global_position.direction_to(point)
#
#		var speed = 3+extra_speed
#
#
#		player.global_position = player.global_position.linear_interpolate(point,speed / dist)
#
#		if dist < 3.01+extra_speed:moveindex += dir
#
#		if moveindex > points.size()-1 or moveindex < 0:
#			player.last_walk_dir = sign(shootdir.x)
#			player.end_moving_on_tube()
#			cooldown.start()
#			player.velocity = shootdir *200
#			player = null




