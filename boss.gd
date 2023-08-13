extends "res://scenes/enemies/introscorpion/enemy.gd"

func _ready():
	$StateMachine/Intro.can_transition = false
	
	


func can_trans():
	$StateMachine/Intro.can_transition = true





func _on_HurtComponent_died(dam):
	if not $StateMachine.enabled:return
	
	$StateMachine.enabled = false
	var bd = preload("res://scenes/boss_death/boss_death.tscn").instance()
	bd.global_position = global_position
	bd.boss = self
	get_tree().current_scene.add_child(bd)
	local_freeze(true,true)
