class_name StateMachine 
extends Node

export var initial_state : NodePath
onready var state :State = null setget set_state

var prev_prev_state = null
var previous_state :State = null
signal changed_state(state, old_state)
onready var entity :Node2D= get_parent()
export var print_state = false
export var enabled = true


func _ready():
	for i in get_children():
		var thestate = i as State
		
		if thestate != null:
			add_state(thestate)
	
	if get_node(initial_state) as State:
		set_state(get_node(initial_state) as State)


func _physics_process(delta):
	if state == null or not enabled:return
	
	if print_state:
		print_debug(state)

	state._state_logic(delta)
	var transition = state._get_transition(delta)			
	
	
	if transition == null:
		return
	set_state(transition)
	
	
	
func set_state(new_state : State):
	if !new_state._can_transition_to(): return
	prev_prev_state = previous_state
	previous_state = state
	emit_signal("changed_state", new_state, previous_state)
	if previous_state != null:previous_state._exit_state(previous_state, new_state)
	if new_state != null:new_state._enter_state(new_state, previous_state	)

	
	state = new_state
	
func add_state(new_state):
	new_state.initialize(entity, self)
	
	if new_state.get_parent() == null:
		add_child(new_state)
	#print_debug(new_state.entity)
