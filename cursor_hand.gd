extends Sprite


var current_control : Control

var t = 0

func request(control):
	z_index = 1
	current_control = control
	t = 0
	show()

func move(control,delta):
	if not is_instance_valid(control):return
	if control != current_control:return
	var newpos = control.get_global_rect().get_center()
	newpos.x = control.get_global_rect().position.x - 8
	
	global_position = global_position.linear_interpolate(newpos,15*delta)
	
func _physics_process(delta):
	if not is_instance_valid(current_control):
		hide()
		return
	t+= delta
	var sval = sin(t*10)
	
	offset.x = sval*3
	

