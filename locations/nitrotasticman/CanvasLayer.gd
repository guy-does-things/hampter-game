class_name BG
extends CanvasLayer




# Called when the node enters the scene tree for the first time.
func _ready():
	if follow_viewport_enable:
		for kid in get_children():
			kid.global_position = $"%RoomRect".get_global_rect().position
			print($"%RoomRect".get_global_rect().position)
			kid.scale = Vector2.ONE/follow_viewport_scale
	
	
func _physics_process(delta):
	visible = $"%RoomRect".is_visible_in_tree()
