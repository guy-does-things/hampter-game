extends AnimatedSprite



func _on_GdtBullet_startup(bullet:GdtBullet):
	if bullet.customdata.get("chargablenoise"):
		play("blue")
		return
	play("default")
