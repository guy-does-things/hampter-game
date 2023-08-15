tool
class_name BreakableBlock
extends StaticBody2D

enum BreakTypes{STOMP,DASH}

export(BreakTypes) var break_type


var index :=0
var room_data :RoomSaveInfo

func setup_interaction_status(index,is_enabled,is_save):
	room_data.modify_pickup_flag(index, is_enabled)
	if is_enabled:
		destroy()

func _ready():
	$Dash.frame = break_type
	if !Engine.editor_hint:
		set_process(false)

func _process(_d):
	$Dash.frame = break_type
	

func blockbreak(type:int):
	if type == break_type and $Dash.visible:
		destroy()
		$AudioStreamPlayer.play()
		$CPUParticles2D.emitting = true
	
func destroy():
	room_data.modify_pickup_flag(index, true)
	#todo add game feel
	$Dash.hide()
	$CollisionShape2D.disabled = true
