extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	$Inventory/GridContainer.playerstatus = $KinematicBody2D/StatusThing
	$Inventory/InventoryBorder.setup_player($KinematicBody2D,$KinematicBody2D.status)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for kid in $CanvasLayer/HBoxContainer.get_children():kid.queue_free()
	
	for motion_input in $KinematicBody2D.weapon.input_buffer:
		var text = MeleeWeapon.Dirs.keys()[MeleeWeapon.Dirs.values().find(motion_input)]
		var l = Label.new()
		l.text = text
		$CanvasLayer/HBoxContainer.add_child(l)
	
	
	if Input.is_key_pressed(KEY_L):
		Globals.died(get_global_mouse_position())
	
	
