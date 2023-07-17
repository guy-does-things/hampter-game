tool
class_name BreakableBlock
extends StaticBody2D

enum BreakTypes{STOMP,DASH}

export(BreakTypes) var break_type


var index :=0
var room_data :RoomSaveInfo

func setup_interaction_status(index,is_enabled,is_save):
	if is_enabled:destroy()



func _ready():
	$Dash.frame = break_type
	if !Engine.editor_hint:
		set_process(false)

func _process(_d):
	$Dash.frame = break_type
	

func blockbreak(type:int):
	if type == break_type:
		destroy()
	
	
func destroy():
	#todo add game feel
	hide()
	$CollisionShape2D.disabled = true
