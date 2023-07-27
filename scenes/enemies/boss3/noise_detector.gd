extends Area2D

signal supercharged()

func bullet_hit(bullet):
	if bullet.customdata.get("chargablenoise"):
		bullet.queue_free()
		emit_signal("supercharged")
