class_name RoomSaveInfo
extends Resource



enum VisitStates{HIDDEN,SEEN,VISITED}
var room : PackedScene
var visit_state = VisitStates.HIDDEN
var pickups := {}
var extra_flags := {}


signal value_changed()


func item_picked_up(id,defval=false):
	return pickups.get(id,defval)

func to_dict()-> Dictionary:
	var dict = {
		visited=visit_state,
		pickups=pickups,
		extra_flags=extra_flags
	}
	return dict

func from_dict(d:Dictionary):
	visit_state=d.get("visited",VisitStates.HIDDEN)
	pickups=d.get("pickups",{})
	extra_flags=d.get("extra_flags",{})


func _to_string():
	return str("visit_state",VisitStates.keys()[visit_state]," pickups:",pickups," extra_room_flags",extra_flags)

