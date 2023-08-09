extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$KinematicBody2D.local_freeze(true,true)
	
	if Globals.is_endgame:
		SavesManager.current_save.beat = true
		SavesManager.save(SavesManager.current_save)
		$CanvasLayer2.hide()
		$Castlev/CPUParticles2D.emitting = true
		$Node2D2.show()
		
	
		yield(castle_destruction(),"completed")
		
		$Castlev/CPUParticles2D.show()
		$Castlev/Smolwater.hide()
		$Castlev.frame = 1
		$CanvasLayer3.show()
		yield(get_tree().create_timer(2.0,false),"timeout")
		
		yield(create_tween().tween_property(
			$CanvasLayer3/ColorRect,
			"color:a",
			1,
			2.0
		),"finished")
		get_tree().change_scene_to(
			preload("res://ends/endscreen.tscn")
		)
				



func _on_Button3_pressed():
	get_tree().quit()
	
	
func castle_destruction():
	var bd = preload("res://scenes/boss_death/boss_death.tscn").instance()
	bd.global_position = $Castlev.global_position
	get_tree().current_scene.call_deferred("add_child",bd)
	yield(bd,"tree_exiting")
	
	var expl = preload("res://bullets/explosion/explosion.tscn").instance()
	expl.scale *= 3
	expl.global_position = $Castlev.global_position
	get_tree().current_scene.add_child(expl)
	
