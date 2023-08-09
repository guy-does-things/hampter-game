tool
extends TileMap

export var open_mode = 0

func _physics_process(delta):
	position.y = 272 * (open_mode+1)
