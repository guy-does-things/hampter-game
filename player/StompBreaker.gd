class_name BreakerCast
extends RayCast2D

export(BreakableBlock.BreakTypes) var break_man_type



func _physics_process(delta):
	if get_collider() is BreakableBlock:
		(get_collider() as BreakableBlock).blockbreak(break_man_type)


func enable():
	enabled = true


func disable():
	enabled = false
