extends State

export var speed := 100.0
var dir := Vector2.LEFT



export(NodePath) var srt 

func _state_logic(dt):
	entity.velocity = dir * speed
	
	
func _get_transition(dt):
	var rr = MapManager.current_room_in.roomrect.get_global_rect()
	$"../../CollisionShape2D".disabled = true
	
	if not rr.intersects($"%DummyRect".get_global_rect()):
		
		entity.velocity = Vector2.ZERO
		return get_node(srt)


func _exit_state(o,n):
	._exit_state(o,n)
	
	if n.name == "DownDash":
		return
		
	$"../../CollisionShape2D".disabled = false
	
	
	
