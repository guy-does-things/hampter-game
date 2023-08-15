extends "res://locations/gate of cage/bossroom.gd"


func _on_EnemySpawner_boss_ded(start):
	if ._on_EnemySpawner_boss_ded(start):
		$AnimationPlayer.play("carcrash")
		
		
func byebye():
	Igt.started = false
	Globals.is_endgame = true
	get_tree().change_scene_to(
		preload("res://titleroom.tscn")
	)

