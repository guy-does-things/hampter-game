extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_on_Interactible_interacted(SavesManager.current_save.global_data.get("holyshitfnaf",false))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Interactible_interacted(istatus):
	if not istatus:return
	$ColorRect/Label.hide()
	$ColorRect/Label2.show()
	SavesManager.current_save.global_data.holyshitfnaf = true
