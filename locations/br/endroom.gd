extends NewestRoom


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _on_AnimationPlayer_animation_finished(anim_name):
	SavesManager.current_save = SavesManager.load_save(SavesManager.current_save.save_path)

	SavesManager.current_save.igt = Igt.gametime
	SavesManager.current_save.bossrush = true

	SavesManager.save(SavesManager.current_save)
	get_tree().change_scene("res://titleroom.tscn")


func _on_Area2D2_body_entered(body):
	Igt.started = false
	$AnimationPlayer.play("end")
