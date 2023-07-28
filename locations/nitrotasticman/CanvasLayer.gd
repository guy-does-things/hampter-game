extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for kid in get_children():
		kid.global_position = $"%RoomRect".get_global_rect().position
		kid.scale = Vector2.ONE/follow_viewport_scale
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
