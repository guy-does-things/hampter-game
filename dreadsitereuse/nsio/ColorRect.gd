tool
extends ColorRect



func _process(delta):
	$ColorRect2.rect_size = rect_size + Vector2(8,8)
	$ColorRect2.rect_position = -Vector2(8,8) / 2


