extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	
	$Inventory/GridContainer.playerstatus = $KinematicBody2D/StatusThing
	$Inventory/InventoryBorder.setup_player($KinematicBody2D,$KinematicBody2D.status)



func setup_save_stuff():
	$KinematicBody2D/StatusThing.unlocked_item(SavesManager.current_save.current_powerups)
	$KinematicBody2D/StatusThing.disabled_bitmask = SavesManager.current_save.disabled_shit
	$KinematicBody2D/StatusThing.hp_stacks = SavesManager.current_save.hp_stacks
	$KinematicBody2D.global_position = SavesManager.current_save.last_position



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for kid in $CanvasLayer/HBoxContainer.get_children():kid.queue_free()
	
	for motion_input in $KinematicBody2D.weapon.input_buffer:
		var text = MeleeWeapon.Dirs.keys()[MeleeWeapon.Dirs.values().find(motion_input)]
		var l = Label.new()
		l.text = text
		$CanvasLayer/HBoxContainer.add_child(l)
	
	
	if Input.is_key_pressed(KEY_L):
		$BisexualGun.dir = $BisexualGun.global_position.direction_to(get_global_mouse_position())
		
		
		$BisexualGun.try_shooting()
		#Globals.hit_fuckery(get_global_mouse_position())
		#print_debug(get_tree().get_nodes_in_group("plrproj"))
		#Globals.died(get_global_mouse_position())
	
	
