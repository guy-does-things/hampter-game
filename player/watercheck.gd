extends Area2D

signal on_water(water)
signal out_of_water(s)

export var was_on_water = false

func sound():
	var asp2d = AudioStreamPlayer2D.new()
	asp2d.bus = "SFX"
	asp2d.volume_db = 5
	asp2d.stream = preload("res://splash.wav")
	asp2d.attenuation = .2
	get_tree().current_scene.add_child(asp2d)
	asp2d.global_position = global_position
	asp2d.connect("finished",asp2d,"queue_free")
	asp2d.play()

	

func _physics_process(delta):
	if get_overlapping_bodies().size() > 0:
		if not was_on_water and not get_overlapping_bodies()[-1].hurts_regardless:
			sound()
		
		emit_signal("on_water",get_overlapping_bodies()[-1])
		was_on_water = true
		return
		
	if was_on_water:
		was_on_water = false
		emit_signal("out_of_water")
