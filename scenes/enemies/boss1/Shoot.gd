extends State

onready var t = $Timer

export var max_shots = 0
var current_shots = 0

func _enter_state(o,n):
	._enter_state(o,n)
	t.start()
	$"../../Flippables/Bootlegeo".frame = 6
	

func _state_logic(dt):
	if current_shots >= max_shots:return

	if not t.is_stopped():return
	
	
	$"%AnimationPlayer".play("shoot")
	t.start()
	$"%Gun".dir.x = sign(entity.global_position.direction_to($"%StatusThing".target.global_position).x)
	$"%Gun".actually_fire()
	yield(t,"timeout")
	current_shots += 1
	
	
	
	

func _get_transition(dt):
	if current_shots >= max_shots:
		current_shots = 0
		return $"%JumpTowardsPlayer"


func _on_Entity_lowhp():
	t.wait_time *= .6
