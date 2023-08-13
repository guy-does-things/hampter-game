extends Node2D

var t = 0

onready var sp := global_position

func _physics_process(delta):

	
	t += delta
	
	if t > .3:
		t = 0
		$HampterSprite.frame = 0 if $HampterSprite.frame == 1 else 1
