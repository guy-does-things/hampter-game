class_name NewMapScreen 	
extends Node2D



var tilemaps := {
	
}

export var rope_color := Color("734111")
export var water_color := Color("5800fff9")
onready var cam :Camera2D= $Camera2D
onready var plrspr = $Yoyoprojtest
var pnis : Node2D
var save_points := []
var waypoint := SaveSprite.new(Vector2.ZERO,true,null,true)


class SaveSprite extends Sprite:
	var real_position : Vector2
	var can_fast_travel : bool
	var is_waypoint : bool
	var room : PackedScene
	
	
	func _init(
		save_point_pos:Vector2,
		fts:bool,
		room:PackedScene,
		waypoint:bool=false
	):
		self.can_fast_travel = fts
		self.real_position = save_point_pos
		self.room = room
		self.is_waypoint = waypoint

		#texture = preload("res://map_saveicons.png")
		hframes = 3
		
		frame = 1
		
		if fts:
			frame = 0
		
		if waypoint:
			frame = 2
		
		
		
	


	func try_intersecting(point:Vector2)-> bool:
		if !visible:
			return false
		
		var intersect = get_rect().has_point(to_local(point)) and can_fast_travel
		scale = Vector2.ONE * (1 + int(intersect) )
		return intersect
	
	
	

	
func border_check(tpos:Vector2, rect:Rect2):
	return (
		tpos.y == 0 or 
		tpos.x == 0 or 
		tpos.y >= floor(rect.end.y/8) - 1 or
		tpos.x >= floor(rect.end.x/8) - 1
	)


func _physics_process(delta):
	move_cam()
	if is_instance_valid(pnis):
		plrspr.global_position = (pnis.global_position / 8)
	
		

	
		

func move_cam():
	if is_instance_valid(pnis):cam.global_position = (pnis.global_position / 8)
	

func _ready():
	waypoint.z_index = 1
	waypoint.visible = SavesManager.current_save.waypoint_position != Vector2.INF
	waypoint.modulate = Color.red
	add_child(waypoint)
	waypoint.global_position = SavesManager.current_save.waypoint_position
	Signals.connect("waypoint_moved",self,"waypoint_info_changed")
	
	add_tilemap("TEST")
	
	# setup tilemaps used for map rendering
	for area in NewSaveData.Areas.values():
		var area_tilemap = add_tilemap(area)
		area_tilemap.modulate = MapManager.get_area_color(area)
		
	add_tilemap("ROPE").modulate = rope_color
	add_tilemap("WATER").modulate = water_color
	
	for i in NewRoomAutoload.room_save_data.values():
		room_discovered(i.room.resource_path,i.visit_state)
	
	

	MapManager.connect("added_room",self,"room_discovered")
	Signals.connect("princess_replacement",self,"princess_replacement")

func princess_replacement(tier,texture):
	if tier < 1:return
	
	waypoint.texture = texture
	waypoint.hframes = 1

	
	for i in save_points:
		i.texture = texture
		i.hframes = 1




func add_tilemap(key):
	var area_tilemap = TileMap.new()
	area_tilemap.tile_set = preload("res://map_ts.tres")
	add_child(area_tilemap)
	area_tilemap.cell_size = Vector2.ONE
	tilemaps[key] = area_tilemap
	return area_tilemap
	
	

func room_discovered(room_path:String,visit_state:int):
	if visit_state == RoomSaveInfo.VisitStates.HIDDEN:
		return
	
	var room = load(room_path)
	var rdata = preload("res://room_dict_data.tres").room_data_dict[room]
	var ro :NewestRoom= room.instance()
	# nvm i have to add it to the tree to avoid a memory leak
	add_child(ro)
	
	var tm :TileMap = ro.get_node("TileMap")



	var rtm :TileMap= tilemaps["TEST"]#[rdata.area]
	var room_tile_global_position = rdata.room_position/8

	for c in tm.get_used_cells():
		if visit_state == RoomSaveInfo.VisitStates.VISITED or border_check(c,rdata.room_rect):
			rtm.set_cellv(
				c + room_tile_global_position,0
			)


	if visit_state == RoomSaveInfo.VisitStates.VISITED:
#		for c in ro.get_node("rope").get_used_cells():
#			tilemaps["ROPE"].set_cellv(c + room_tile_global_position,0)
#		for c in ro.get_node("Water").get_used_cells():
#			tilemaps["WATER"].set_cellv(c + room_tile_global_position,0)

	
		for i in ro.get_children():
			if i.is_in_group("save"):
				var save : Node2D = i
				
				# adds a save point icon :3
				var s = SaveSprite.new(save.position+rdata.room_position,save.can_fast_travel,room)
				save_points.append(s)
				s.global_position = room_tile_global_position + (save.position / 8)
				add_child(s)







	ro.queue_free()



func waypoint_info_changed():
	pass
	waypoint.global_position = SavesManager.current_save.waypoint_position
	waypoint.visible = SavesManager.current_save.waypoint_position != Vector2.INF

