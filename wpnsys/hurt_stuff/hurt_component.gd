#tool
class_name HurtComponent
extends Area2D

export var is_enemy := false


enum DamageTypes{
	PLACEHOLDER=0
}




signal hurted(dam,type)
signal died(dam,type)
export var reduction_pierce : float = 1
export var reduction_shock : float= 1
export var reduction_fire : float= 1
export var reduction_blunt : float= 1
export var reduction_defaut : float= 1
export var reduction_toxic_plant_gating : float= 1
export var reduction_egg : float= 1

export var KBmult = Vector2.ONE
export var path_entitystatus : NodePath
onready var entitystatus :StatusThing= get_node(path_entitystatus)
onready var entity := get_parent()

var hurtsfx = AudioStreamPlayer.new()
var can_hurt = true



func _ready():
	
	add_child(hurtsfx)
	hurtsfx.bus = "SFX"
	monitoring = false
	collision_mask = 16
	collision_layer = 16
	
	if is_enemy:
		add_to_group("enemy")
	else:
		add_to_group("player")


	if entity:
		entity.add_to_group("enemy" if is_enemy else "player")

#
#func _process(delta):
#	print_debug(collision_layer)

func get_real_damage(damage:int, type:int)-> int:
	var current_type_red = 1
	match type:
		DamageTypes.PIERCE:current_type_red = reduction_pierce
		DamageTypes.SHOCK:current_type_red = reduction_shock
		DamageTypes.FIRE:current_type_red = reduction_fire
		DamageTypes.BLUNT:current_type_red = reduction_blunt
		DamageTypes.TOXICPLANTGATING:current_type_red = reduction_toxic_plant_gating
		DamageTypes.FUNNYEGGDAMAGE:current_type_red = reduction_egg
	return int( ceil( (damage * current_type_red) * reduction_defaut) )
			


	
	

func hurt(dam:int,damtype:int, dir:Vector2, kbstr:int, hit_is_enemy:bool):
	if hit_is_enemy == is_enemy or !can_hurt:
		return false
	
	dam = get_real_damage(dam,damtype)

	if "velocity" in entity:
		entity.velocity += (dir * kbstr) * KBmult
	
	entitystatus.current_hp = (entitystatus.current_hp - dam)
	
	if dam > 0:
		hurtsfx.play()
		emit_signal("hurted",dam,damtype)
		#Signals.emit_signal("thing_hurt",self)
	
	if entitystatus.current_hp <= 0:
		emit_signal("died",dam,damtype)
		
	return true










