extends "res://locations/nitrotasticman/car_chase.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$BossDoor2.can_move = SavesManager.current_save.beat
