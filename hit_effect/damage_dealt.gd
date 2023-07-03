extends Label


var hit_position :Vector2 
export var offset : Vector2
func _process(delta):
	rect_global_position = hit_position - ((rect_size / 2 ) * rect_scale) + (offset*5)


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
