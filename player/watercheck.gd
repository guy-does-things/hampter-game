extends Area2D

signal on_water(water)
signal out_of_water(s)

func _physics_process(delta):
	if get_overlapping_bodies().size() > 0:
		emit_signal("on_water",get_overlapping_bodies()[-1])
		return
	emit_signal("out_of_water")
