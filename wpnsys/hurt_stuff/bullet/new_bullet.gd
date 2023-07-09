tool
class_name GdtBullet
extends Node2D

enum Colliders{
	ALLY,
	ENEMY,
	BODY
}

signal movement(bullet)
signal collided(type, bul, collider)
signal startup(bullet)
signal frozen(bullet)
signal unfrozen(bullet)



export var damage := 0 setget set_damage
export var speed = 0.0
export(Shape2D) var hitbox setget set_hitbox
export(Resource) var _bullet_props = (BulletPropeties.new() as Resource)
export var is_puppet = false
export var velocity : Vector2 setget set_velocity
var is_enemy = false setget set_is_enemy

onready var life_timer = $LifeTimer
onready var space_state := get_world_2d().direct_space_state
var lifetime = 1 setget set_lifetime


var muzzle : Node2D
var dir := Vector2.ZERO

var _funnyphysparms := Physics2DShapeQueryParameters.new()
var area : HitBox
	

var canmove = true
var customdata := {}
var last_collider = null





func set_velocity(nvel : Vector2):	
	#if Engine.editor_hint or !Globals.get_if_world_frozen()[0]:
	velocity = nvel

#
#func _on_Area2D_body_entered(body):
#
#




func _ready():
	area = $Area2D
	area.add_to_group("bullet")
#	area.connect("actually_hit",self,"_on_Area2D_actually_hit")
#	area.connect("ally_hit",self,"_on_Area2D_ally_hit")
#	area.connect("body_entered",self,"_on_Area2D_body_entered")

	#Globals.connect("changed_frozen_state",self,"world_frozen")
	
	#world_frozen(Globals.get_if_world_frozen()[0],false)
	area.damage = damage
	
	if Engine.editor_hint:return
	
	set_hitbox(hitbox)
	set_is_enemy(is_enemy)
	
	_funnyphysparms.collision_layer = area.collision_mask
	_funnyphysparms.exclude = [area.get_rid()]
	
	life_timer.wait_time = lifetime
	life_timer.start()
	emit_signal("startup",self)


	
func set_lifetime(nlifetime : float):
	lifetime = nlifetime
	
	if life_timer:
		life_timer.wait_time = lifetime
		life_timer.start()
	

func set_is_enemy(nise):
	is_enemy = nise
	if !area:return
	area.is_enemy = nise
	

func change_propeties(nprops):
	_bullet_props = nprops



func set_hitbox(nhbox : Shape2D):
	hitbox = nhbox
	_funnyphysparms.collide_with_areas = true
	_funnyphysparms.set_shape(hitbox)
	if get_node_or_null("%CollisionShape2D"):
		$"%CollisionShape2D".shape = nhbox
		

func set_damage(ndamage):
	damage = ndamage
	if area:
		area.damage = damage
		
	
	
# uses the physics engine to avoid tunneling (unless the physics body has already been entered)
# by then it dosen't matter because by then it's gonna get deleted or 
# one of the bullet's special effects is related to that
func _physics_process(delta):	
	#print_debug(last_collider is TileMap)
	if !Engine.is_editor_hint():
		if canmove:# and not Globals.get_if_world_frozen()[0]:
			try_moving(delta)
	
		emit_signal("movement",self)
		
		_funnyphysparms.transform = global_transform
		_funnyphysparms.motion = Vector2.ZERO
		
		var result = space_state.get_rest_info(_funnyphysparms)
		
		parse_shape_coli_results(result)
		
	
	else:
		set_hitbox(hitbox)


func try_moving(delta):
	_funnyphysparms.transform = global_transform
	_funnyphysparms.motion = get_velocity(delta)
	var excuded = [area.get_rid()]
	if is_instance_valid(last_collider):
		excuded.append(last_collider.get_rid())
	
	
	
	var funnyphysthing :Array = space_state.cast_motion(_funnyphysparms)
	_funnyphysparms.exclude = excuded

	if !is_puppet:
		var castraymovmult = funnyphysthing[1]
		
		
		if (_bullet_props as BulletPropeties).ignores_anti_tunneling_measures:
			castraymovmult = 1
		
		global_position += _funnyphysparms.motion * castraymovmult
		
	


func parse_shape_coli_results(result:Dictionary):

	if result.empty():return
	
	var collider_id = result.get("collider_id")
	var collider = null
	
	if !collider_id:return
	
	collider = instance_from_id(collider_id)
	
	
	if collider is HurtComponent:
		# last collider is ambigous because i standed there and realized that it would be bad if
		# it could ignore tilemaps
		last_collider = collider
		var is_enemy_or_ally = Colliders.ALLY if collider.is_enemy == area.is_enemy else Colliders.ENEMY
		emit_signal("collided",is_enemy_or_ally,self,result)
		return
	
	if collider is StaticBody2D or collider is TileMap:

		emit_signal("collided",Colliders.BODY,self,result)	
	
	


func get_velocity(delta : float)-> Vector2:return ( velocity + (dir.normalized() * speed) ) * (delta)




func _on_Area2D_body_entered(body):
	if (_bullet_props as BulletPropeties).deletes_on_wall:
		queue_free()
	

func _on_Area2D_actually_hit(target):
	if (_bullet_props as BulletPropeties).deletes_on_enemy_hit:
		queue_free()


func _on_Area2D_ally_hit(ally):
	if (_bullet_props as BulletPropeties).deletes_on_ally_hit:
		queue_free()



func _on_Timer_timeout():
	if _bullet_props.deletes_on_timeout:
		queue_free()

