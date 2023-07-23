extends Node


var time_multiplier := 1.0 setget set_time_multiplier

# the actual tiomescale, can be 0
var realtimescale = 1 setget set_realtimescale

var timer = Timer.new()

const EPSILON = 1.401298e45
const HITFREEZETIMEMULT = 0.05

func _ready():
	add_child(timer)
	timer.one_shot = true



func set_realtimescale(nts):
	realtimescale = nts
	Engine.time_scale = nts


func set_time_multiplier(nts):
	if nts == 0:
		time_multiplier = EPSILON
		return
	time_multiplier = nts


func hitstop(duration:float):
	set_realtimescale(HITFREEZETIMEMULT)
	timer.wait_time = duration * Engine.time_scale
	timer.start()
#	print(timer.wait_time)
	yield(timer,"timeout")
	
	set_realtimescale(1)
	
	
func stop_hit_stop():
	return
	timer.stop()
	set_realtimescale(1)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
