extends Node2D


func _ready():
	
	Igt.started = true
	for piped in preload("res://room_dict_data.tres").pipe_data:
		var transpipe = RoomTransPipe.new()
		transpipe.room_to_load_a = NewRoomAutoload.get_data_from_packedscene(load(piped.a))
		transpipe.room_to_load_b = NewRoomAutoload.get_data_from_packedscene(load(piped.b))
		transpipe.global_position = piped.pipepos
		transpipe.points = piped.points
		get_tree().current_scene.add_child(transpipe)
	
	
	
	player_setup()
	

	
func player_setup():
	var f = File.new()
#
	if not f.file_exists("user://seed"):
		randomize()
	else:
		f.open("user://seed",File.READ)
		var fline = f.get_line()
		var used_seed = hash(fline)
		seed(used_seed)
	
	
	
	NewRoomAutoload.load_room(
		NewRoomAutoload.get_data_from_packedscene(load(SavesManager.current_save.loaded_room))
	)
	
#	SavesManager.current_save.beat= true
	#SavesManager.current_save.global_data.holyshitfnaf = true
	

	#SavesManager.current_save.global_data.holyshitfnaf = true
	$Inventory/GridContainer.playerstatus = $KinematicBody2D/StatusThing
	#$KinematicBody2D/StatusThing.current_hp = 0
	$Inventory/InventoryBorder.setup_player($KinematicBody2D,$KinematicBody2D/StatusThing)
	$KinematicBody2D/StatusThing.connect("item_unlocked",$Inventory/ItemPopup,"item_unlocked")
	
	# i forgot to do this!!	

	$KinematicBody2D.global_position = SavesManager.current_save.last_position
	$KinematicBody2D/StatusThing.disabled_bitmask = SavesManager.current_save.disabled_shit
	$KinematicBody2D/StatusThing.unlocked_item(SavesManager.current_save.current_powerups,true)
	

	($KinematicBody2D/StatusThing as StatusThing).hp_stacks = SavesManager.current_save.hp_stacks
