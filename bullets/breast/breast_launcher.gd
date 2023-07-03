extends Sprite


var rotm = 1

func _on_GdtBullet_collided(type, bul:GdtBullet, collider):
	if type != GdtBullet.Colliders.BODY:return
	
	
	bul.dir = collider.normal.rotated(45)
	bul.is_puppet = true
	
	flip_h = sign(collider.normal.x) == -1
	flip_v = sign(collider.normal.y) == 1
	
	if sign(collider.normal.x) != 0:
		$AnimationPlayer.play("breastjiggleX")
	else:
		$AnimationPlayer.play("breastjiggleY")

	yield($AnimationPlayer,"animation_finished")
	bul.is_puppet = false
	
	
	
