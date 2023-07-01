tool
extends Node2D

# have to do this so the spinslash rotates in the direction you are facing
export var a_rotation : float setget set_a_rotation; func set_a_rotation(rot):
	a_rotation = rot;rotation_degrees = rot * scale.x
	
	
	


func _on_SpinSlash_exited():
	rotation_degrees = 0
	$HampterSprite.frame = 0
