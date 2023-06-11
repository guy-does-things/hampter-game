class_name Entity
extends KinematicBody2D


var velocity : Vector2
var can_slide = true

func _physics_process(delta):
	try_move()

func try_move():
	if can_move():
		move()


func can_move():
	return not(get("motion/sync_to_physics") or not can_slide)

func move():
	velocity = move_and_slide(velocity,Vector2.UP)
