#placeholder water, will be replaced/reworked evantually ( as in a system)

extends Area2D


onready var valid_position  = $Position2D.global_position


func _ready():
	connect("body_entered",self,"body_entered")
	
	

func body_entered(body):
	if body.is_in_group("player") and not body.can_swim:
		body.global_position = valid_position
		body.velocity = Vector2.ZERO
