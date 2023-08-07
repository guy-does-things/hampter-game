extends Node2D


onready var bike = $BiE
onready var hbcheck = $Area2D
var bul :GdtBullet
var speedmult = 1
var wall_hit  = false

signal bullet_hit(enemy)
signal wall_hit()


func _on_GdtBullet_startup(bullet:GdtBullet):
	bullet.customdata.bikehand = self
	hbcheck.collision_mask = 1024
	bul = bullet
	remove_child(bike)
	bike.scale.x = bullet.dir.x
	get_tree().current_scene.add_child(bike)
	bike.global_position = bullet.global_position
	bike.velocity = bullet.get_velocity(1)
	


func _on_GdtBullet_movement(bullet):
	bullet.global_position = bike.global_position
	hbcheck.global_position = bike.global_position
	
	
	if bike.velocity == Vector2.ZERO:
		bike.velocity = bul.get_velocity(1)
	
	if not wall_hit:
		bike.velocity.x = bul.get_velocity(speedmult).x
		wall_hit = bike.is_on_wall()
		
	#	bike.rotation_degrees = 0
		
		if wall_hit:
			emit_signal("wall_hit")
			bullet.customdata.on_wall = true
			bike.velocity.y = -200
			bike.velocity.x = -bul.dir.x * 100
			bul.damage = 0
			bike.set_collision_mask_bit(5,false)
			bike.rotation_degrees += rand_range(0,15*bul.dir.x)
		return
	
	bike.rotation_degrees -= 5 * bul.dir.x
	bike.scale += Vector2(
		.05*sign(bike.scale.x),
		.05*sign(bike.scale.y)
		)
	bike.z_index = 1
		



func _exit_tree():
	if is_instance_valid(bike):bike.queue_free()


func _on_Area2D_area_entered(area:Area2D):
	if wall_hit:return
	
	if area is HitBox and area.monitoring and area.is_enemy != bul.is_enemy:
		bul.dir = global_position.direction_to(bul.muzzle.global_position)
		speedmult += .1
		bul.is_enemy = !bul.is_enemy
		if bul.is_enemy:
			bul.dir.x *= -1
		emit_signal("bullet_hit",bul.is_enemy)



func _on_VisibilityNotifier2D_screen_exited():
	bul.queue_free()
