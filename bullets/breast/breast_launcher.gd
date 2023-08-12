extends Sprite

var rmult = 1

func _on_GdtBullet_collided(type, bul:GdtBullet, collider):
	if type != GdtBullet.Colliders.BODY:return
	if $AnimationPlayer.is_playing():return
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D.attenuation = 1.0
	$AudioStreamPlayer2D.volume_db = 2
	var ynorm = 1 
	

	bul.speed += 1
	
	if bul.dir.y == 0:
		bul.dir.y = 1

	if collider.normal.y != 0:
		bul.dir.y = collider.normal.y

	if collider.normal.x != 0:
		bul.dir.x = collider.normal.x
		pass

	
	
	bul.is_puppet = true
	
	flip_h = sign(collider.normal.x) == -1
	flip_v = sign(collider.normal.y) == 1
	
	if sign(collider.normal.x) != 0:
		$AnimationPlayer.play("breastjiggleX")
	else:
		$AnimationPlayer.play("breastjiggleY")

	yield($AnimationPlayer,"animation_finished")
	bul.is_puppet = false
	rmult *= -1
	
	
	
