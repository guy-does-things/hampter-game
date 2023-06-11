class_name BreakableBlock
extends StaticBody2D

enum BreakTypes{STOMP,DASH}

export(BreakTypes) var break_type



func blockbreak(type:int):
	if type == break_type:destroy()
	
	
func destroy():
	
	#todo add game feel
	queue_free()
