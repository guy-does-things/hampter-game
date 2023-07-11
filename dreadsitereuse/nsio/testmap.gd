tool
extends Node2D


export var data := {}




export var do_fixed_color = false
export var fixed_color : Color

func add_t(pos:Vector2,area:int,visit_status:int):
	data[pos] = [area,visit_status]
	
	
	
func u():
	$MultiMeshInstance2D.multimesh.visible_instance_count = data.size()
	var keys = data.keys()
	for i in data.size():
		var pos = keys[i]
		var d = data[pos]
		var area = d[0]


		$MultiMeshInstance2D.multimesh.set_instance_transform_2d(i,Transform2D(0,pos))
		var color :Color= MapManager.get_area_color(area)
		
		if d[1] == RoomSaveInfo.VisitStates.SEEN:
			color = color.darkened(.75)
			
		if !do_fixed_color:
			$MultiMeshInstance2D.multimesh.set_instance_color(i,color)
		if do_fixed_color:
			$MultiMeshInstance2D.multimesh.set_instance_color(i,fixed_color)
		
