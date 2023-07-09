extends State


export(NodePath) var ohshitimstuckpath; onready var ohshitimstuck = get_node(ohshitimstuckpath)

export var speed : float = 10

var dir : Vector2
var can_launch = false

func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	entity.velocity = Vector2.ZERO

func update_dir():
	dir = entity.global_position.direction_to($"%StatusThing".target.global_position)
	$Timer.start()
	


func _exit_state(new_state, old_state):
	._exit_state(new_state, old_state)
	entity.velocity = Vector2.ZERO
	$Timer.stop()
	dir = Vector2.INF
	can_launch = false




func _state_logic(dt):
	if can_launch:
		entity.velocity = dir * speed
	elif dir == Vector2.INF or dir == Vector2.ZERO:
		if $"%NewPlayerDetector".target_visib_check($"%StatusThing".target,false):update_dir()
	

func _get_transition(dt):
	var e :KinematicBody2D= entity as KinematicBody2D 
	
	if !(e and e.get_slide_count() > 0 and can_launch):return
	
	var slide = e.get_slide_collision(0)
	
	entity.global_position += slide.normal

	return ohshitimstuck
	


func _on_Timer_timeout():
	can_launch = true
