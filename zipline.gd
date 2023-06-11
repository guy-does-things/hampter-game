class_name ZipLine
extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var a = Area2D.new()
	a.add_to_group("zipline")
	
	
	add_child(a)
	if points.size() < 2:queue_free()
	
	
	for i in range(points.size()):
		if i +1 > points.size() - 1:return
		
		
		var cshape = CollisionShape2D.new()
		var line = RayShape2D.new()
		cshape.shape = line
		line.length = points[i].distance_to(points[i+1])
		cshape.position = points[i]#.distance_to(points[i+1])
		cshape.look_at(cshape.position)
		cshape.rotation_degrees -= 90
		
		a.add_child(cshape)
		
