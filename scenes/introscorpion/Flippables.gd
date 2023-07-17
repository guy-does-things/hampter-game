extends Node2D
export var scalemult = 1

export var disabled = false

func _physics_process(delta):
	var targ = $"%StatusThing".target
	if is_instance_valid(targ) and not disabled:
		flip(global_position.direction_to(targ.global_position).x)
		
		
func flip(dirx):
	dirx = sign(dirx)
	if dirx == 0:return
	
	scale.x = dirx* scalemult






func _on_Shoryuken_exited():
	disabled = false


func _on_Shoryuken_entered():
	disabled = true
