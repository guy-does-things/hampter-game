tool
class_name Door
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
export(bool) var closed = true
export(bool) var br_no_open = false


onready var ds = $DoorSprite



func _ready():
	if closed:
		ds.region_size_y = initial_door_size_y
		return
	
	ds.region_size_y = 0
	
	
	#$DoorSprite.region_rect.size.x = door_sizex
	
	
func _process(delta):
	
	
	
	$CollisionShape2D.shape = shape
	$CollisionShape2D.position.y = $DoorSprite.region_rect.size.y / 2
	
	shape.extents = $DoorSprite.region_rect.size /2
	if Engine.editor_hint:
		_ready()
		return
	

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

	yield(current_tweenk.tween_property(ds,"region_size_y",end_value,time),"finished")
	current_tweenk = null
	amode = AnimModes.NONE


func force_close():
	print("WhY DON?T WDSAHDSA CLOE ")
	can_move = false
	tween_door(AnimModes.LOWERING,initial_door_size_y,.1)

func force_open():
	if br_no_open:return
	
	can_move = false
	tween_door(AnimModes.GOINGUP,0,.5)






func _on_Trigger_body_exited(body):
	if !can_move:return
	if not body.is_in_group("player"):return
	
	if not amode in [AnimModes.NONE,AnimModes.LOWERING]:return
	

	
	tween_door(AnimModes.GOINGUP,initial_door_size_y)


func _on_close_trigger_body_entered(body):
	force_close()
