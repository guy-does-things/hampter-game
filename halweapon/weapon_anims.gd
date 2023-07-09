extends AnimationPlayer



func  play(name: String = "", custom_blend: float = -1, custom_speed: float = 1.0, from_end: bool = false):
	.play(name,custom_blend,custom_speed,from_end)
	

func _on_Attack1_entered():
	play("attack1")
	

func _on_None_entered():
	play("RESET")


func _on_Attack2_entered():
	play("attack2")


func _on_Attack3_entered():
	play("attack3")


func _on_PogoStic_entered():
	play("pogo")
	


	
func _on_Uppercut_entered():
	play("uppercut")


func _on_SpinSlash_entered():
	play("spinslash")


func _on_SonicSlash_entered():
	play("soulthrow")


func _on_BTrhow_entered():
	play("boobthrow")


func _on_PipeBomb_entered():
	play("pipebomb so cool")
