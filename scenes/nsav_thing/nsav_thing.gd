tool
extends "res://scenes/nsav_thing/ninteractibble.gd"



func interact(cinteractionstatus,is_loading_game:=false)-> void:
	plr.velocity = Vector2.ZERO
	var es:StatusThing=plr.get_node("EntityStatus")
	es.current_ap = es.MAX_AP
	es.current_hp = es.MAX_HP
	
	SavesManager.current_save.last_position = plr.global_position
	SavesManager.current_save.loaded_room = NewRoomAutoload.get_current_room().filename
	SavesManager.current_save.area = aria_of_interactible
	SavesManager.current_save.igt = Igt.gametime
	Signals.emit_signal("trying_to_save",false)
	.interact(cinteractionstatus,is_loading_game)
