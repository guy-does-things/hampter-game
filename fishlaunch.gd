extends State


func _enter_state(new_state, old_state):
	._enter_state(new_state, old_state)
	entity.velocity.x = entity.global_position.direction_to($"%StatusThing".target.global_position).x*400
	entity.velocity.y = -40
#
func _state_logic(delta):
	$"%Sprite".scale.y = sign(entity.velocity.x)
	$"%Sprite".frame = 1
	$"%Sprite".look_at(entity.global_position+entity.velocity)


func _on_VisibilityNotifier2D_screen_exited():
	if state_machine.state == self:
		entity.queue_free()
