class_name HitBox
extends Area2D

signal actually_hit(enemy)
signal ally_hit(ally)


export(HurtComponent.DamageTypes) var damage_type
export(float) var hit_iframes := .1 setget set_hit_iframes
export(int) var damage = 0
export(int) var knockback = 0
export(bool) var is_enemy = false
export(bool) var can_hit_multiple_times = false

onready var timer = $Timer
onready var parent = get_parent()

var __hurt_comps := []
var __flush_colliders_instead_of_hurting = false


func _init():add_to_group("hitbox")

func _ready():
	add_to_group("hitbox")
	#set_collision_mask_bit(3,true)
	timer.wait_time = hit_iframes



func set_hit_iframes(hdelay):
	
	hit_iframes = hdelay
	if timer:
		timer.wait_time = hit_iframes
		timer.stop()
		#timer.start()
		


func _on_Area2D_area_entered(area:HurtComponent):
#	print_debug(area)
	if area:
		if actually_hurt(area):
			#print_debug("WHAT THE FUck")
			emit_signal("actually_hit",area)
		
			if can_hit_multiple_times:
				if not area in __hurt_comps:
					__hurt_comps.append(area)
					timer.start()
		

		
		elif area.is_enemy == is_enemy:
			emit_signal("ally_hit",area)

func _on_Area2D_area_exited(area:HurtComponent):
	if area:
		__hurt_comps.erase(area)



func _on_Timer_timeout():
	if __flush_colliders_instead_of_hurting:
		timer.stop()
		__hurt_comps = []
		__flush_colliders_instead_of_hurting = false
		
	for i in __hurt_comps:
		actually_hurt(i)
		

		
func actually_hurt(hc:HurtComponent):
	#print_debug("da fuck")
	return hc.hurt(
		damage,
		damage_type,
		global_position.direction_to(hc.global_position).normalized(),
		knockback,
		is_enemy
	)
	


func flush_colliders():
	__flush_colliders_instead_of_hurting = true





