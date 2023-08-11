extends KinematicBody2D


enum MoveStates{END,START}
export(MoveStates) var current_move_state = MoveStates.END

export var start_position = Vector2.ZERO
export var end_position = Vector2.ZERO
var is_moving = false
var current_tween = null






func _physics_process(delta):
	movement_thing()
	


func movement_thing():
	if is_moving:return
	
	is_moving = true
	var pos = end_position if current_move_state==MoveStates.END else start_position

	
	yield(get_tree().create_timer(1.5,false),"timeout")
	current_tween = create_tween().tween_property(
		self,
		"position",
		pos,
		pos.distance_to(position)/200.0
	)
	
	yield(current_tween,"finished")
	
	is_moving = false
	
	current_move_state = MoveStates.START if current_move_state == MoveStates.END else MoveStates.END
	
	


