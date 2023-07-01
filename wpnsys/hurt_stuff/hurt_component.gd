#tool
class_name HurtComponent
extends Area2D

export var is_enemy := false







signal hurted(dam)
signal died(dam)
export var KBmult = Vector2.ONE
export var path_entitystatus : NodePath
onready var entitystatus :StatusThing= get_node(path_entitystatus)
onready var entity := get_parent()

var hurtsfx = AudioStreamPlayer.new()
var can_hurt = true
var current_priority = -1
var iframetimer = Timer.new()


func _ready():
	add_child(iframetimer)
	add_child(hurtsfx)
	iframetimer.connect("timeout",self,"no_iframes")
	iframetimer.one_shot = true
	iframetimer.wait_time = 1.0
	
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

	
	
func hurt(dam:int, dir:Vector2, kbstr:int, hit_is_enemy:bool,hit_priority:int):
	if hit_priority <= current_priority:
		return false

	if hit_is_enemy == is_enemy or !can_hurt:return false
	
	print("ow",hit_priority)
	
	if "velocity" in entity:
		entity.velocity += (dir * kbstr) * KBmult
	
	entitystatus.current_hp = (entitystatus.current_hp - dam)
	current_priority = hit_priority
	
	iframetimer.start()
	
	if dam > 0:
		hurtsfx.play()
		emit_signal("hurted",dam)
		#Signals.emit_signal("thing_hurt",self)
	
	if entitystatus.current_hp <= 0:
		emit_signal("died",dam)
		
	return true



func no_iframes():
	current_priority = -1








