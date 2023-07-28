tool
class_name RoomNode
extends GraphNode

var data : Dictionary



func setup(room_data:Dictionary,index=0):

	var o = room_data.get("connection_node_position")
	if o == null:
		o = Vector2.DOWN * (96*index)
	
	offset = o

	data = room_data
	#self_modulate = MapManager.get_area_color(data.area)
	rect_size = (data.room_rect.size / 16)
	var room_inst : NewestRoom = room_data.room_scene.instance()
	name = room_data.room_name
	title = room_data.room_name
	#print_debug(room_data)
	for i in range(room_data.transition_rooms.size()):
		var r = room_inst.get_node("Transitions").get_child(i)
		var l = Label.new()
		#l.add_font_override("font", preload("res://fonts/font.tres"))
		l.text = r.name
		l.size_flags_vertical = l.SIZE_EXPAND | l.SIZE_SHRINK_CENTER
		add_child(l)
		
		set_slot(
			i,true,0,Color.white,true,0,Color.white,null,null
		)

	
func can_connect(slot:int)-> bool:
	return data.transition_rooms[slot] == null

func set_connection_scene(slot:int,scene:PackedScene):
	data.transition_rooms[slot] = scene
	

func get_scene()->PackedScene:
	return data.room_scene
	
func get_room_index(scene:PackedScene):
	for i in range(data.transition_rooms.size()):	
		if scene == data.transition_rooms[i]:
			return i

	
func _physics_process(delta):
	if data:
		data.connection_node_position = offset


func _on_GraphNode_resize_request(new_minsize):
	rect_size = new_minsize
