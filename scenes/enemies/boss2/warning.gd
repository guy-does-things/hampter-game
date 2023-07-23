extends Sprite


var t = 0
var enable = false
var cindex = 0

export(Array,Color) var COLORS = [
	
]


func _physics_process(delta):
	if not enable:
		t = 0
		cindex = 0
		return
		
	t+= delta
	
	if t > .12:
		t = 0
		cindex += 1
		frame = cindex % 2
		$Line2D.default_color = COLORS[frame]

	
