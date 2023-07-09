extends Node2D
export var scalemult = 1

func _physics_process(delta):
	var targ = $"%StatusThing".target
	if is_instance_valid(targ):
		flip(global_position.direction_to(targ.global_position).x)
		
		
func flip(dirx):
	dirx = sign(dirx)
	if dirx == 0:return
	
	scale.x = dirx* scalemult
