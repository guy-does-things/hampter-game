tool
extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mp :Vector2
var ct : int

func _draw():
	if ct == -1:return
	draw_rect(
		Rect2(mp*16,Vector2.ONE*16),
		Color(1,1,1,1)
	)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not Engine.editor_hint:return
	if not Input.is_physical_key_pressed(KEY_D):return
	
	mp = (get_local_mouse_position() / 16).floor()
	ct = get_cellv(mp)
	
	if ct != -1:
		print_debug(get_cell_autotile_coord(mp.x,mp.y))
		update()
	
