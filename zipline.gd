tool
class_name ZipLine
extends Line2D



func _ready():
	var point_offset = Vector2(0,width/2)
	default_color = Color.white
	texture = preload("res://rope.png")
	texture_mode =Line2D.LINE_TEXTURE_TILE
	if Engine.editor_hint:return
	z_index= -1
	var a = Area2D.new()
	a.collision_layer = 65536
	a.add_to_group("zipline")
	
	
	add_child(a)

	var poly = CollisionPolygon2D.new()
	var polyg :PoolVector2Array
	
	
	for i in range(points.size()):
		var point = points[i]
		polyg.append(point+point_offset)
		polyg.append(point-point_offset)
		point_offset *= -1
	
	print(polyg)
	
	poly.polygon = polyg
	a.add_child(poly)

