class_name Stun 
extends State

signal t_started()
var t := Timer.new()
export var starts_once_on_floor = false
export var wait_time = 1.2
export(NodePath) var return_override 
var t_started = false


func _ready():
	add_child(t)
	t.wait_time = wait_time
	t.one_shot = true


func _enter_state(new_state, old_state):

	._enter_state(new_state, old_state)
	start_timer()

func _exit_state(new_state, old_state):
	._exit_state(new_state, old_state)
	t_started = false


	
func start_timer():
	if not t.is_stopped():return
	
	if not (entity.is_on_floor() or not starts_once_on_floor):return
	t.start()
	t_started = true
	emit_signal("t_started")
	

	
func _get_transition(dt):
	
	if t.is_stopped() and t_started:
		
		if not return_override.is_empty():return get_node(return_override)
		return state_machine.get_node(state_machine.initial_state)

	start_timer()
