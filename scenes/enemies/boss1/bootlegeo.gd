extends "res://boss.gd"

var outline_colors =[
	Color.black,
	Color.white,
	Color.red,
	Color.orangered
	
]

signal lowhp

var is_second_phase = false

export var o_color = 0.0 setget set_ocolor; func set_ocolor(val):
	if not is_inside_tree():return
	
	o_color = val
	$Flippables/Bootlegeo.material.set_shader_param("rep_col",outline_colors[int(o_color)%4])
	pass



func _ready():
	$HurtComponent.hurt(100,Vector2.ZERO,false,0,false)



func hp_check(dam, is_water):
	if is_second_phase:return
	
	if $"%StatusThing".current_hp < $"%StatusThing".MAX_HP / 2:
		$Flippables/Bootlegeo/CPUParticles2D.hue_variation= -0.14
		$Flippables/CPUParticles2D.hue_variation = -0.14
		emit_signal("lowhp")
		is_second_phase = true


func _on_Gun_proj_created(proj):
	if is_second_phase:
		proj.get_node("CPUParticles2D").hue_variation = -0.14
