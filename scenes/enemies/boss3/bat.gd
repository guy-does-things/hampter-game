extends "res://boss.gd"



		

func tp_to_pos(pos:Vector2,caller,mname=""):
	#if $StateMachine.state == $StateMachine/BloodSuck:
	print_debug($StateMachine.previous_state," ",$StateMachine.prev_prev_state," ",caller,": ",mname)
	global_position = pos
	$ScaleFuckery.play("teleport_out")
	yield($ScaleFuckery,"animation_finished")
	
	$ScaleFuckery.play_backwards("teleport_out")
	yield($ScaleFuckery,"animation_finished")
		
		
func ripoffdraculateleport(caller,m=""):
	yield(get_tree(),"idle_frame")
	var emptryrglobal = get_roomr()
	
	if not emptryrglobal:return
	
	var farthest_position_from_player = 0
	var farthest_dist_from_player = -INF
	#bullet.customdata.get("chargablenoise")
	for i in 2:
		var rolled_pos = rand_range(emptryrglobal.position.x,emptryrglobal.end.x)
		
		var dist = (abs($"%StatusThing".target.global_position.x - rolled_pos))
		
		if dist > farthest_dist_from_player:farthest_position_from_player = rolled_pos
	
	
	yield(tp_to_pos(Vector2(farthest_position_from_player,global_position.y),caller,m),"completed")
	

func teleport_to_side(isleft,caller,m=""):
	yield(get_tree(),"idle_frame")
	var rr = get_roomr(false)
	if not rr:return
	
	var pos : Vector2
	pos.y = (rr.end.y-32)
	
	
	if isleft:
		pos.x = rr.position.x + 16
		
	else:pos.x = rr.end.x -32
	
	
	yield(tp_to_pos(pos,caller,m),"completed")
	
	
	
	


func get_roomr(gets_real_roomr:=false):
	var room = MapManager.current_room_in
	if not room:return
	if gets_real_roomr:
		return room.roomrect.get_global_rect()
	
	var emptyr :Control = room.get_node_or_null("EmptyRect")
	if not emptyr:return 
	return emptyr.get_global_rect()


func _on_Entity_entered_hitstun():
	$PhysicsStuff.gravity_enabled = true
	print_debug("???")


func _on_Entity_exited_hitstun():
	$PhysicsStuff.gravity_enabled = false
	


func _on_SuckDetector_body_entered(body):
	if $StateMachine.state in [$"%BloodSuck", $"%DashFly"]:
		# set to suck state
		$StateMachine.set_state($StateMachine/WhenSheSuckingYouNutsButYouGangsta)
		


func _on_DashFly_exited():
	
	$"%SuckDetector".monitoring = false
