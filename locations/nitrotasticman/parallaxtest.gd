extends Node2D

export var speed = 1

func _physics_process(delta):
	get_child(0).region_rect.position.x += speed/scale.x * delta
