extends Area2D

signal on_water(water)
signal out_of_water(s)

var was_on_water = false

func _physics_process(delta):
	if get_overlapping_bodies().size() > 0:
		emit_signal("on_water",get_overlapping_bodies()[-1])
		was_on_water = true
		return
		
	if was_on_water:
		was_on_water = false
		emit_signal("out_of_water")
