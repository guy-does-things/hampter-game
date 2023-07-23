extends Node2D



onready var gun = $Flippables/Node2D
onready var flippables = $Flippables
var target : Node2D


func _physics_process(delta):
	if target:
		flippables.flip(
			target.global_position.x - global_position.x
		)
		
		look_at(target.global_position)
	
	
	gun.try_shooting()
	gun.deal_with_dir(
		Vector2.RIGHT.rotated(rotation)
	)
	


func _on_Node2D_charging(gun):
	$"%SpriteSheet".frame = 1
	



func _on_Node2D_fullypoweredup(gun):
	$"%SpriteSheet".frame = 2
	gun.stop_firing()


func _on_Node2D_fired(gun):
	$"%AnimationPlayer".play("spitit")


func _on_Node2D_proj_created(proj:GdtBullet):
	proj.rotation_degrees = rotation_degrees


func _on_Timer_timeout():
	Globals.died(global_position)
	queue_free()
