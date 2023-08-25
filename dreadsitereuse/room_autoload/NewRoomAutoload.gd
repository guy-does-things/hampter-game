extends Node
signal loaded_room(room)

const MAX_ROOMS_LOADED = 2

# the one null value is needed to make it actually editable from a tool script
# dosen't actually need to be all times, it just has to be defined
export var room_data_resource : Resource
var room_dictionary : Dictionary

# were made thinking they were gonna be used as traditional stacks
# thought wrong (not renaming because naming conflicts :3)
var data_stack := []
var room_stack := []



var _name_2_scene_dict := {}
var room_save_data : Dictionary


# 0 is items, 1 is room
var area_counts := {}





func _ready():
	if not room_data_resource:return
	setup_dict()	
	regenerate_room_save_data()

	


func regenerate_room_save_data():
	for i in room_dictionary.keys():
		
		var room_save_info := RoomSaveInfo.new()
		room_save_data[i] = room_save_info
		room_save_info.room = i.resource_path
		room_save_data[i].from_dict(SavesManager.current_save.room_data.get(i.resource_path,{}))

		room_save_info.connect("value_changed",SavesManager.current_save, "room_save_modified", [i.resource_path,room_save_info])

func pleasekillme(thing_d):
	print(
		thing_d
		
	)



func setup_dict():
	room_dictionary.clear()
	for i in room_data_resource.room_data_dict:
		var rr :Dictionary = room_data_resource.room_data_dict[i]
		rr.customdata = rr.get("customdata",{})
		area_counts[rr.area] = area_counts.get(rr.area,[0,0])
		area_counts[rr.area][1] += 1		
		area_counts[rr.area][0] += rr.item_count
		room_dictionary[rr.room_scene] = rr
		_name_2_scene_dict[rr.room_name] = rr.room_scene
		



func load_room(room_data,_dep=null):
	# if room already is instanced, don't load again
	if room_data in data_stack:
		return
			
	data_stack.append(room_data)

	# actually instance the room	
	var rinstance = room_data.room_scene.instance()
	
	rinstance.global_position = room_data.room_position
	get_tree().current_scene.call_deferred("add_child",rinstance)
	rinstance.setup(room_data)
	room_stack.append(rinstance)
	emit_signal("loaded_room",rinstance)
	
	# forcefully notifies the third room loaded that it's free trial of 
	# [E X I S T A N C E] has run out :3
	if room_stack.size() > MAX_ROOMS_LOADED:
		room_stack.pop_front().queue_free()
		data_stack.pop_front()

	

# reorders the arrays to make sure the current room is the last one 
func entered_room(room,scene):
	var scene_id = data_stack.find(scene)

	data_stack.remove(scene_id)
	data_stack.append(scene)
	
	room_stack.append(room_stack.pop_at(scene_id))
		

# wow it actually works

		
func get_current_room()->NewestRoom:
	if room_stack.size() > 0:
		return room_stack[-1]
	return null
	
	
func get_room_data_from_name(n:String):
	return room_dictionary.get(_name_2_scene_dict.get(n,""))


func get_data_from_packedscene(room_scene:PackedScene):
	return room_dictionary.get(room_scene,null)
	
