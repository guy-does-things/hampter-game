extends KinematicBody2D


enum MoveStates{END,START}
export(MoveStates) var current_move_state = MoveStates.END

export var start_position = Vector2.ZERO
export var end_position = Vector2.ZERO
var is_moving = false
var current_tween = null

var can_move = false
var just_started = false

func _ready():
	Signals.connect("player_exited_room",self,"room_exited")

func _physics_process(delta):
	if not can_move:return
	movement_thing()


func room_exited(room):
	if room != get_parent():return
	if current_tween != null:
		current_tween.stop()
		
	is_moving = false
	can_move = false
	just_started = true
	position = start_position


func movement_thing():
	if is_moving:return
	
	is_moving = true
	var pos = end_position if current_move_state==MoveStates.END else start_position

	if just_started:
		just_started = false
	else:
		yield(get_tree().create_timer(1.5,false),"timeout")
	
	current_tween = create_tween()
	current_tween.tween_property(
		self,
		"position",
		pos,
		pos.distance_to(position)/200.0
	)
	
	yield(current_tween,"finished")
	
	is_moving = false
	
	current_move_state = MoveStates.START if current_move_state == MoveStates.END else MoveStates.END
	
	




func _on_Area2D_body_entered(body):
	can_move = true
