tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"d


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		store_positions()
		return
	player_setup()
	
	
	
func store_positions():
	var datadict = preload("res://room_dict_data.tres")
	var transpipes := []
	
	for i in get_children():
		var room :NewestRoom = i as NewestRoom
		if i is RoomTransPipe:transpipes.append(i)
		if not room:continue
		var room_scene = load(room.filename)
		datadict.room_data_dict[room_scene].room_position = room.global_position
		
	datadict.pipe_data = []
	
	for pipe in transpipes:
		var ra :NewestRoom = pipe.get_node(pipe.room_a)
		var rb :NewestRoom = pipe.get_node(pipe.room_b)
		datadict.pipe_data.append({a=ra.filename,b=rb.filename,pipepos=pipe.global_position,points=pipe.points})
	
		
	
	ResourceSaver.save("res://room_dict_data.tres",datadict)
		
	
	
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
		
		
		
	
	
	

	$Inventory/GridContainer.playerstatus = $KinematicBody2D/StatusThing
	$Inventory/InventoryBorder.setup_player($KinematicBody2D,$KinematicBody2D/StatusThing)
	$KinematicBody2D/StatusThing.connect("item_unlocked",$Inventory/ItemPopup,"item_unlocked")
	#$KinematicBody2D.global_position = SavesManager.current_save.last_position
	$KinematicBody2D/StatusThing.unlocked_item(SavesManager.current_save.current_powerups,true)
	
	$KinematicBody2D/StatusThing.disabled_bitmask = SavesManager.current_save.disabled_shit


func _process(delta):
	if Input.is_key_pressed(KEY_L):
		$Inventory2/BossWarning.warning_popup()


func save_map_to_ss():
	var img = Image.new()
	img.create(
		480*32,270*32,
		false,
		get_viewport().get_texture().get_data().get_format()
	)
	
	var start_offset = Vector2(-3840,-2320) 

	for x in range(0,32):
		for y in 32:
			img.lock()
			$Camera2D.global_position = start_offset + Vector2(x*480,y*270)
			yield(VisualServer,"frame_post_draw")
			var vptex = get_viewport().get_texture().get_data()
			vptex.flip_y()
			
			img.blit_rect(
				vptex,
				Rect2(Vector2.ZERO,Vector2(480,270)),
				Vector2(x*480,y*270)
			)
			
			
			img.unlock()
	
	img.save_png("res://maptest.png")

