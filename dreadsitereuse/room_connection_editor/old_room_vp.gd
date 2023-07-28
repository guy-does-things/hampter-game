extends ViewportContainer



func _on_ViewportContainer_resized():
	$Viewport.size = rect_size
	print_debug(get_parent().rect_size)
	
func _ready():
	_on_ViewportContainer_resized()
	get_tree().get_root().connect("size_changed", self, "_on_ViewportContainer_resized")
