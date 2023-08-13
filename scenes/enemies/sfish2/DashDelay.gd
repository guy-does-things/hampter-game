extends State


var t = Timer.new()

var looks_at_p = true
var exit = false
var dir = Vector2.ZERO


func _ready():
	t.one_shot = true
	t.wait_time = .7
	t.connect("timeout",self,"timeout")
	add_child(t)


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	t.start()
	exit = false
	looks_at_p = true
		
func _state_logic(dt):
	
	if looks_at_p:
		$"%Flippable".disabled = false
		
		if is_instance_valid($"%StatusThing".target):entity.look_at($"%StatusThing".target.global_position)
		

func _get_transition(delta):
	if exit:
		return $"%Delay"

		

func timeout():
	looks_at_p = false
	if is_instance_valid($"%StatusThing".target):
		dir = entity.global_position.direction_to($"%StatusThing".target.global_position)
		$"%Flippable".disabled = true
		
		yield(get_tree().create_timer(.15,false),"timeout")
		entity.velocity = dir * 500
	
	exit = true
	looks_at_p = true
