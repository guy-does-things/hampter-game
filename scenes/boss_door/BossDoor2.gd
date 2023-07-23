tool
extends StaticBody2D

enum AnimModes{
	NONE,
	GOINGUP
	LOWERING,
	
}



var shape = RectangleShape2D.new()
var current_tweenk :SceneTreeTween= null
var amode = AnimModes.NONE
export var can_move = true

export(int) var initial_door_size_y =96
export(int) var door_sizex =16

func _ready():
	$DoorSprite.region_size_y = initial_door_size_y
	#$DoorSprite.region_rect.size.x = door_sizex
	
	
func _process(delta):
	
	
	
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position.y = $DoorSprite.region_rect.size.y / 2
	
	shape.extents = $DoorSprite.region_rect.size /2
	if Engine.editor_hint:
		_ready()
		return
	
#	if Input.is_action_just_pressed("platform"):
#		force_close()
#	if Input.is_action_just_pressed("ui_down"):
#		force_open()


func _on_Trigger_body_entered(body):
	if !can_move:return
	if not body.is_in_group("player"):return
	
	if not amode in [AnimModes.NONE,AnimModes.GOINGUP]:return
	

	
	tween_door(AnimModes.LOWERING,0)
	



func tween_door(mode,end_value,time=1.4):
	if current_tweenk:
		current_tweenk.kill()
		current_tweenk = null
		
	amode = mode
	current_tweenk = create_tween()
	yield(current_tweenk.tween_property($DoorSprite,"region_size_y",end_value,time),"finished")
	current_tweenk = null
	amode = AnimModes.NONE


func force_close():
	can_move = false
	tween_door(AnimModes.LOWERING,initial_door_size_y,.1)

func force_open():
	can_move = false
	tween_door(AnimModes.GOINGUP,0,.5)






func _on_Trigger_body_exited(body):
	if !can_move:return
	if not body.is_in_group("player"):return
	
	if not amode in [AnimModes.NONE,AnimModes.LOWERING]:return
	

	
	tween_door(AnimModes.GOINGUP,initial_door_size_y)
