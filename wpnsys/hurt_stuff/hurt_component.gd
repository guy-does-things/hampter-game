#tool
class_name HurtComponent
extends Area2D

export var is_enemy := false





export var damage_override = -1

signal hurted(dam,is_water)
signal died(dam)
onready var entitystatus :StatusThing= get_node(path_entitystatus)
onready var entity := get_parent()
export var is_dummy = false
export var KBmult = Vector2.ONE
export var path_entitystatus : NodePath
var can_hurt = true
var current_priority = -1
var iframetimer = Timer.new()
var total_combo_damage = 0
var current_tweenk :SceneTreeTween
var iframe_flash_timer := Timer.new()
var is_fucking_dead = false



func _ready():
	
	add_child(iframe_flash_timer)
	add_child(iframetimer)
	iframetimer.connect("timeout",self,"no_iframes")
	
	iframetimer.one_shot = true
	iframetimer.wait_time = 1.0
	iframe_flash_timer.wait_time = 0.15
	iframe_flash_timer.connect("timeout",self,"flash")
	
	
	monitoring = false
	collision_mask = 16
	collision_layer = 16
	
	if is_dummy:
		collision_mask = 512
		collision_layer = 512
			
	
	
	if is_enemy:
		add_to_group("enemy")
	else:
		add_to_group("player")


	if entity:
		entity.add_to_group("enemy" if is_enemy else "player")

func flash(STOP=false):
	if entity.modulate.r > 1 or STOP:
		entity.modulate = Color(1,1,1)
	else:
		entity.modulate = Color(100,100,100)
		

	
	
func hurt(dam:int, dir:Vector2, kbstr:int, hit_is_enemy:bool,hit_priority:int,is_water=false):
	
	if is_fucking_dead:return
	if dam == 0:return
	if damage_override != -1:dam =damage_override
	
	if hit_priority <= current_priority:
		return false

	if hit_is_enemy == is_enemy or !can_hurt:return false
	
	if "velocity" in entity:
		entity.velocity += (dir * kbstr) * KBmult
	
	entitystatus.current_hp = (entitystatus.current_hp - dam)
	current_priority = hit_priority
	total_combo_damage += dam
	print(current_priority,"  ",hit_priority," ",total_combo_damage)
	
	if current_tweenk:
		current_tweenk.stop()

	

	iframetimer.start()
	flash()
	iframe_flash_timer.start()
	Globals.hit_fuckery(global_position)
	
	emit_signal("hurted",dam,is_water)

	
	
	
	if entitystatus.current_hp <= 0:
		emit_signal("died",dam)
		Globals.died(global_position)
		no_iframes()
		is_fucking_dead = true
		
	return true





	

func no_iframes():
	current_priority = -1
	
	var damagelabel = preload("res://hit_effect/damage_dealt.tscn").instance()
	damagelabel.hit_position = global_position
	damagelabel.text = str(total_combo_damage)
	get_tree().current_scene.add_child(damagelabel)
	total_combo_damage = 0
	flash(true)
	iframe_flash_timer.stop()
	







