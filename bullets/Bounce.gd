extends Node


func _on_GdtBullet_collided(type, bul:GdtBullet, collider):
	if type != GdtBullet.Colliders.BODY:return
	
	bul.dir = bul.dir.bounce(collider.normal)
	bul.look_at(bul.global_position-bul.get_velocity(1))
	


func _on_GdtBullet_startup(bullet):
	pass # Replace with function body.
