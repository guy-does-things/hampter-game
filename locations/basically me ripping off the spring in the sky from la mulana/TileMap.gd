extends TileMap

#
#func _ready():
#	Signals.connect("player_entered_room",self,"room_loaded")

func _physics_process(delta):
	
	if not SavesManager.current_save.global_data.get("seals",0) >= 3:
		return
	
	
	if not SavesManager.current_save.global_data.get("deletedwall",false):
		var expl = preload("res://bullets/explosion/explosion.tscn").instance()
		
		expl.scale *= 3
		expl.global_position = $"%Area2D".global_position
		get_tree().current_scene.add_child(expl)
		
		
	for i in get_used_cells_by_id(7):
		set_cellv(i,-1)
	SavesManager.current_save.global_data.deletedwall = true
