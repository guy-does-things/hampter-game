extends State



export(NodePath) onready var statr = get_node(statr)
var can_exit = false
var jumping = false



func _state_logic(dt):
	$"%Flippables".disabled = true
	if entity.is_on_floor() and not jumping:
		jump_towards()

func _exit_state(old_state, new_state):
	._exit_state(old_state, new_state)		
	can_exit = false
	$"%Flippables".disabled = false


func jump_towards():
	
	jumping = true
	$"%Sprite".frame = 9
	$"%AnimationPlayer".stop()
	$"%Flippables".disabled = true
	var d1  = (entity.global_position.x - MapManager.current_room_in.roomrect.get_global_rect().position.x)
	var d2  = (entity.global_position.x - MapManager.current_room_in.roomrect.get_global_rect().end.x)

	var used_pos = MapManager.current_room_in.roomrect.get_global_rect().position.x	
	
	if abs(d2) > abs(d1):
		used_pos = MapManager.current_room_in.roomrect.get_global_rect().end.x

	var dist = (used_pos-entity.global_position.x)*3
	$"%Flippables".flip(-dist)
	yield(get_tree().create_timer(.2,false),"timeout")
	
	
	entity.velocity.x = dist
	$"%Jumper".jump_force = -600
	$"%Jumper".jump()
	yield($"%idle","landed")
	$"%JumpHB".monitoring = false
	can_exit = true

	

func _get_transition(dt):
	if can_exit:
		
		jumping = false
		return statr
