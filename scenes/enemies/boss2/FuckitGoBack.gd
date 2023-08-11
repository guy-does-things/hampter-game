extends State

export var speed = 500

export(NodePath) var tate_to_return


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)
	$"%Flippables".disabled = false
	$"../../CollisionShape2D".disabled = false
	

func _get_transition(delta):
	var rr :Rect2= MapManager.current_room_in.roomrect.get_global_rect()
	
	var dir =  entity.global_position.direction_to(rr.get_center())
	$"%Flippables".disabled = true
	$"%Flippables".flip(dir.x)
	$"../../CollisionShape2D".disabled = true
	
	
	if entity.global_position.distance_to(rr.get_center()) < 32:
		return get_node(tate_to_return)
	
	
	entity.velocity = dir * speed
