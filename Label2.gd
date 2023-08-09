extends Label

onready var sp = rect_position
var t = 0


func _physics_process(delta):
	rect_position = Vector2(sp.x,sp.y + (sin(t*4)*6))
	t += delta
	
	
