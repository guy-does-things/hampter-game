extends Sprite


signal ended

func _on_Stomp_entered():
	emit_signal("ended")
