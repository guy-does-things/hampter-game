extends "res://scenes/nsav_thing/ninteractibble.gd"

signal game_load_interact(interacted)

var room_data : RoomSaveInfo
var index : int = -1 setget set_index; func set_index(i):if index == -1:index = i



func setup_interaction_status(index,status:bool,is_load_game:bool):
	interact(status,is_load_game)


func interact(cinteractionstatus:bool,is_loading_game:=false)-> void:
	if !is_loading_game:
		interacted = set_interaction_status(cinteractionstatus)
		room_data.pickups[index] = interacted
		emit_signal("interacted",interacted)
	else:
		interacted = cinteractionstatus
		# basically the same, execpt that only triggers if loading a save 
		emit_signal("game_load_interact",interacted)

	




