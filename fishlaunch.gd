extends State



onready var targ = $"../../../KinematicBody2D"



func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	entity.velocity.x = entity.global_position.direction_to(targ.global_position).x*200
	entity.velocity.y = -40
#
func _state_logic(delta):
	$"../../Sprite".look_at(entity.global_position+entity.velocity)


func _on_VisibilityNotifier2D_screen_exited():
	if state_machine.state == self:
		entity.queue_free()
