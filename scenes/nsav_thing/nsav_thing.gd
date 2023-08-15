tool
extends "res://scenes/nsav_thing/ninteractibble.gd"



func interact(cinteractionstatus,is_loading_game:=false)-> void:
	var es:StatusThing=plr.get_node("StatusThing")
	es.current_hp = es.MAX_HP
	
	
	SavesManager.current_save.hp_stacks = es.hp_stacks
	SavesManager.current_save.last_position = plr.global_position
	SavesManager.current_save.current_powerups = es.item_bitmask
	SavesManager.current_save.disabled_shit = es.disabled_bitmask
	SavesManager.current_save.hp_stacks = es.hp_stacks
	SavesManager.current_save.loaded_room = NewRoomAutoload.get_current_room().filename
	SavesManager.current_save.area = aria_of_interactible
	SavesManager.current_save.igt = Igt.gametime
	SavesManager.current_save.played = true
	#Signals.emit_signal("trying_to_save",false)
	print_debug(SavesManager.save(SavesManager.current_save))
	.interact(cinteractionstatus,is_loading_game)
	saved()
	
func saved():	
	var damagelabel = preload("res://hit_effect/damage_dealt.tscn").instance()
	damagelabel.text = str("SAVED!")
	damagelabel.hit_position = global_position	
	get_tree().current_scene.add_child(damagelabel)

