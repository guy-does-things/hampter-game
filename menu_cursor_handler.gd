extends Control

var t = 0
var last_thing_grabbed :Control
# Called when the node enters the scene tree for the first time.
func _ready():
	connect_focus_signals()
	
func connect_focus_signals():
	for kid in get_children():
		if not kid is Control:continue
		
		(kid as Control).connect("focus_entered",self,"thing_grabbed",[kid])


func _physics_process(delta):
	
	$"%Cursorhand".move(last_thing_grabbed,delta)
		

	

func thing_grabbed(thing:Control):
	last_thing_grabbed = thing
	$"%Cursorhand".request(thing)



