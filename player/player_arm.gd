tool
extends Sprite



var scalex = 1
var has_wpn = false



export(int) var a_frame
export(Vector2) var a_pos



func _physics_process(delta):
	if !has_wpn:
		frame = a_frame
		position = a_pos
	else:
		pass
		
#
## lastdir is misleading, it's actually facing dir
#func aim(dir:Vector2,lastdir:Vector2):
#	if !has_wpn:
#		rotation_degrees = 0
#		return
#
#	var usedir = dir
#
#	if usedir == Vector2.ZERO:
#		usedir =lastdir
#
#	usedir.x = abs(usedir.x)
#	var fstatus = get_parent().frame == 7
#
#	flip_h = fstatus
#	frame = 9
#	position = Vector2(4,0)
#	if fstatus:position.x *= -1
#
