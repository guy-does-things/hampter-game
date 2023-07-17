extends Control

signal started_fast_travel()

var plr :Node2D

func setup_plr(p):
	$"%Map".pnis = p
	plr = p


func is_front_window():
	# does this work???
	if get_parent().get_children()[-1] == self:
		return true

	# get what is the current slot,
	# will be cached later, used for optimization purposes 

	var slot := get_parent().get_children().find(self)

	# slart from this node's slot and loop trough the other children
	# as to not loop through unecessary nodes
	for i in range(slot,get_parent().get_child_count()):
		var okid :Control= get_parent().get_child(i)
		# ingore if its self or hidden
		if okid == self or !okid.visible:continue
		elif okid.visible:return false

	return true


func _physics_process(delta):
	
	
	$"%Map".invisible = !is_visible_in_tree() or !is_front_window()


func _on_Map_fast_travel(save_point:NewMapScreen.SaveSprite):
	NewRoomAutoload.load_room(NewRoomAutoload.get_data_from_packedscene(save_point.room))
	
	emit_signal("started_fast_travel")
	if is_instance_valid(plr):
		print(save_point.real_position)
		plr.global_position = save_point.real_position
	
	
	

func deminimize():
	$"%Map".can_do_tp_input()
	.deminimize()

func minimize(is_controller_input:bool):
	$"%Map".can_do_tp_input = false
	.minimize(is_controller_input)



func _on_Panel2_show_travel_map():
	$"%Map".can_fast_travel = false
	yield(get_tree().create_timer(.2),"timeout")
	$"%Map".can_fast_travel  = true
