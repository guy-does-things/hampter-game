extends Resource
class_name NewSaveData

const DEFAUT_NAME = "name"
const DEFAUT_ROOM = "res://new_rooms/caves/caves_room_0.tscn"

enum Areas{CAVES, UNDERWATER_CAVES, DESERT, CITY, BROKENLAB,MALLPLAZA}


# creation info
var initial_creation : int
var version :String 
var name :String = DEFAUT_ROOM
var loaded_room := DEFAUT_ROOM
var save_path : String

# world data
var room_data := {}
var area_counts := {}

# game data
var area : int = Areas.CAVES
var igt : int = 0


# player data
var current_powerups :int=0
var disabled_shit :int = 0
var last_position := Vector2(416,255)
var waypoint_position := Vector2.INF

var map_rooms := {}
var global_data ={}


func _init():
	for i in Areas.values():
		area_counts[i] = [0,0]


func to_dict():
	return {
		name = name,
		area_counts = area_counts,
		room_data = room_data,
		area = area,
		igt = igt,
		current_powerups = current_powerups,
		last_position = last_position,
		loaded_room = loaded_room,
		waypoint_position = waypoint_position,
		disabled_shit=disabled_shit,
		globals=global_data
	}

func as_buffer():
	return var2bytes(to_dict())

func from_dict(dict:Dictionary):
	initial_creation = dict.get("initial_creation",0)
	name = dict.get("name","name")
	area_counts = dict.get("area_counts",{})
	room_data = dict.get("room_data",{})
	area = dict.get("area",Areas.CAVES)
	igt = dict.get("igt",0)
	current_powerups = dict.get("current_powerups",0)
	disabled_shit = dict.get("disabled_shit",0)
	last_position = dict.get("last_position",last_position)
	loaded_room = dict.get("loaded_room",loaded_room)
	waypoint_position = dict.get("waypoint_position",Vector2.INF)
	global_data = dict.get("globals",{})


func room_save_modified(room_path,room_save_info:RoomSaveInfo):
	room_data[room_path] =room_save_info.to_dict()
	
	
func md5_hash():
	return str(as_buffer()).md5_buffer()


func room_entered(area:int):
	var area_count :Array= area_counts.get(area,[0,0])
	area_count[1] += 1
	area_counts[area] = area_count


func item_collected(area:int):
	var area_count :Array= area_counts.get(area,[0,0])
	area_count[0] += 1
	area_counts[area] = area_count
	
	
	
	
	
	
