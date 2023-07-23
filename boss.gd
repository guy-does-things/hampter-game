extends "res://scenes/enemies/introscorpion/enemy.gd"

func on_spawned():
	$StateMachine/Intro.can_transition = true
	
	
func _process(dt):
	if Input.is_key_pressed(KEY_L) and $StateMachine.enabled:
		_on_HurtComponent_died(0)
		#on_spawned()




	

func _on_HurtComponent_died(dam):
	if not $StateMachine.enabled:return
	
	$StateMachine.enabled = false
	$HurtComponent.current_priority = INF
	local_freeze(true,false)
	var bd = preload("res://scenes/boss_death/boss_death.tscn").instance()
	bd.global_position = global_position
	bd.boss = self
	get_tree().current_scene.add_child(bd)
