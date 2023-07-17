tool
class_name WaterTileMap
extends TileMap


export(Vector2) var position_to_eject_to
export var change_clay = true


func _init():
	tile_set = preload("res://water_tileset.tres")
	cell_size = Vector2(16,16)

func _ready():
	if !change_clay:return
	collision_layer =64
	collision_mask =64



func _draw():
	if !Engine.editor_hint:return
	
	var hamptertex = preload("res://raw_sprites/player/singlehampter.png")
	
	draw_texture(
		hamptertex,
		position_to_eject_to - (hamptertex.get_size() / 2)
	)
	
func _process(delta):
	update()



func get_eject_pos():
	return to_global(position_to_eject_to)
