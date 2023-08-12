extends "res://oos_respwawner/out_of_screen_spawner.gd"




var plr : Entity

func spawn_enemy(_player, room):	
	if Engine.editor_hint;
		.spawn_enemy(_player,room)
		return
		
		
	if _player:plr = _player
	
	.spawn_enemy(_player,room)
	if _player and is_instance_valid(enem):
		enem.global_position.y = plr.global_position.y
	
	
func _process(delta):
	print(enem.global_position)
