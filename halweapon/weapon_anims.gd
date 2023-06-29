extends AnimationPlayer




func _on_Attack1_entered():
	play("attack1")


func _on_None_entered():
	stop()
	$"../SpriteSheet".frame = 0


func _on_Attack2_entered():
	play("attack2")


func _on_Attack3_entered():
	play("attack3")


func _on_PogoStic_entered():
	stop()
	$"../SpriteSheet".frame = 4
	


func _on_PogoStic_exited():
	$"../SpriteSheet".rotation_degrees = 0
