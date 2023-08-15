extends "res://locations/gate of cage/Sign.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if not SavesManager.current_save.beat:
		sgn_dialog.text = "only the strong shall pass.\nprove yourself!"
		return
	sgn_dialog.text = """you have proven yourself worthy...
you may pass, but be warned that you may not leave
until you reach the end, or perish in the way there."""
