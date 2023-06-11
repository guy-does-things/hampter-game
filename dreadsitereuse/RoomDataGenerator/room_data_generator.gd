tool
extends Node2D


export(Array,PackedScene) var rooms
export var modify_resource := false



func _physics_process(delta):
	if Engine.get_idle_frames()%20 or !modify_resource:return
	var rdictcont :RoomDictContainer= load("res://room_dict_data.tres")#RoomDictContainer.new()
	if rdictcont == null:
		rdictcont = RoomDictContainer.new()

	
	for i in rooms:
		var room_name = i.resource_path.split("/")[-1].split(".tscn")[0]
		
		var current_room_data = rdictcont.room_data_dict.get(i,{})
		var current_room_instance :NewestRoom = i.instance(	)		
		current_room_data.area = current_room_instance.room_area
		current_room_data.room_name = room_name
		current_room_data.room_scene = i
		current_room_data.room_rect = current_room_instance.get_node("RoomRect").get_rect()
		current_room_data.elevators = []
		var item_count = 0
		
		var objects = current_room_instance.get_node("RoomObjectManager").get_children()
		current_room_data.room_position = current_room_data.get("room_position",Vector2.ZERO)
		
		for obj_in in range(objects.size()):
			var object = objects[obj_in]
			if object.is_in_group("item"):
				item_count += 1
				 
		
		current_room_data.item_count = item_count
		current_room_data.connection_node_position = current_room_data.get("connection_node_position")


		var trans_triggers :Array= current_room_data.get("transition_rooms",[])
		trans_triggers.resize(current_room_instance.get_node("Transitions").get_child_count())


		current_room_data.transition_rooms = trans_triggers
		rdictcont.room_data_dict[i] = current_room_data

	var r = ResourceSaver.save(
		"res://room_dict_data.tres",rdictcont
	)
	modify_resource = false
	print(r ==OK)

