extends Control

var t = 0
var last_thing_grabbed :Control

export(NodePath) var cursorpath;onready var ch=get_node(cursorpath)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_focus_signals()
	
	
func connect_focus_signals():
	for kid in get_children():
		if not kid is Control:continue
		
		(kid as Control).connect("focus_entered",self,"thing_grabbed",[kid])


func _physics_process(delta):
	
	if not is_instance_valid(ch):return
	
	ch.move(last_thing_grabbed,delta)
		

	

func thing_grabbed(thing:Control):
	last_thing_grabbed = thing
	if not is_instance_valid(ch):return
	ch.request(thing)



