extends Node2D

signal added_room_to_map(room)
signal save_station_found(sav_stat)

signal added_room(room_path,visit_state)


var current_room_in : NewestRoom setget set_current_room


var is_first_room := true
var was_first_room = false


var rooms_discovered = {}




	

func set_current_room(ncur_room:NewestRoom):
	var last_room = current_room_in
	current_room_in = ncur_room
	
	if set_room_visit_state(ncur_room.filename,RoomSaveInfo.VisitStates.VISITED):
		pass
		#SavesManager.current_save.room_entered(ncur_room.room_area)





func set_room_visit_state(room_path:String,new_state:int):
	var last_state = (NewRoomAutoload.room_save_data.get(load(room_path)) as RoomSaveInfo)#rooms_discovered.get(room_path,RoomSaveInfo.VisitStates.HIDDEN)
	if last_state == null:return
	
	
	if new_state > last_state.visit_state:
		last_state.visit_state = new_state
		last_state.emit_signal("value_changed")

		emit_signal("added_room",room_path,new_state)
		return true
	return false







static func get_area_color(location:int):
#	match location:
#		SaveData.Areas.CAVES:
#			return Color("696a6a")
#		SaveData.Areas.UNDERWATER_CAVES:
#			return Color("306082")
#		SaveData.Areas.DESERT:
#			return Color("d9a066")
#		SaveData.Areas.BROKENLAB:
#			return Color("524b24")
#		SaveData.Areas.CITY:
#			return Color("99e550")
#		SaveData.Areas.MALLPLAZA:
#			return Color("9badb7")
		
	return Color("639bff") 


