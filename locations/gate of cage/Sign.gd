extends Sprite

export(Resource) var sgn_dialog = null





func _on_Interactible_interacted(istatus):
	DialogBox.setup_d_sequence(sgn_dialog)
	
