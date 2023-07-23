extends State


signal play_attack_anim

export(NodePath) var think_state_path;onready var think_state = get_node(think_state_path)
export(NodePath) var dir_state_path;onready var dir_state = get_node(dir_state_path)



var attacked = false

var target = null



func _enter_state(o,n):
	target = $"%StatusThing".target 
	attacked = false
	._enter_state(o,n)
	$Timer.start()
	

func _get_transition(dt):
	if attacked:
		return think_state





func battack():
	if state_machine.state != self:return
	
	var dir = entity.global_position.direction_to(target.global_position)
	dir.y = 0
	dir.x = sign(dir.x)
	
	var sattack = preload("res://bullets/soul_attack.tscn").instance()
	sattack.is_enemy = true
	sattack.global_position = entity.global_position + Vector2.DOWN *4
	sattack.scale.x = dir.x
	sattack.speed = 200
	sattack.damage = 3
	sattack.lifetime = 10
	sattack.dir = dir
	get_tree().current_scene.add_child(sattack)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		battack()
		attacked = true


func _on_Timer_timeout():
	if state_machine.state != self:return
	emit_signal("play_attack_anim")
