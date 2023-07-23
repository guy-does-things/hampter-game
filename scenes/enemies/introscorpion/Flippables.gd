extends Node2D
export var scalemult = 1

export var disabled = false
export var is_moving_y = false
export var has_sthing = true



func _physics_process(delta):
	if not has_sthing:return
	
	var targ = $"%StatusThing".target
	if is_instance_valid(targ) and not disabled:
		flip(global_position.direction_to(targ.global_position).x)
		
		
func flip(dirx):
	dirx = sign(dirx)
	if dirx == 0:return
	
	if is_moving_y:
		scale.x = 1
		scale.y = dirx* scalemult
		return
	
	scale.x = dirx* scalemult






func _on_Shoryuken_exited():
	disabled = false


func _on_Shoryuken_entered():
	disabled = true
