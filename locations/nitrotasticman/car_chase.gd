extends NewestRoom





func _on_Area2D_body_entered(body):
	for BG in $BGS.get_children():
		for BGpart in BG.get_children():
			if "speed" in BGpart:
				create_tween().tween_property(
					BGpart,
					"speed",
					0,
					.5
				).set_trans(Tween.TRANS_LINEAR)
	
