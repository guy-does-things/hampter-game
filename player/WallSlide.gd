extends State


signal started_grace
export(NodePath) var idle
onready var idle_state = get_node(idle)

var grace_given = false
var exit_now = false
var dir : Vector2

func _enter_state(new_state, old_state):
	grace_given = false
	exit_now = false
	._enter_state(new_state, old_state)
	dir = $"%DirComp".last_dir


func _can_transition_to():
	return true


func _get_transition(delta):
	if !entity.is_on_wall() and $WallGrace.is_stopped() and !grace_given:
		emit_signal("started_grace")
		$WallGrace.start()
		grace_given = true
	
	
	if (!entity.is_on_wall() and $WallGrace.is_stopped()) or exit_now:
		return idle_state
	
	
	if entity.is_on_floor():
		return idle_state


func _on_Node2D_jumped(jump):

	if state_machine.state == self:
		entity.velocity.x = dir.x * -125
		exit_now = true
