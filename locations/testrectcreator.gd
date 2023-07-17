tool
extends ReferenceRect


export(NodePath) var line

export(Rect2) var initial_r 



func _process(delta):
	var linenode : Line2D = get_node_or_null(line)
	
	if not linenode:return
	
	rect_global_position = linenode.points[0]
	initial_r.position = rect_global_position
	var r :Rect2= initial_r
	
	for point in linenode.points:
		r = r.expand(point)
		
	rect_size = r.size
	rect_global_position = r.position
