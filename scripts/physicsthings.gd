class_name PhysicsStuff
extends Node


const AIR_FRICTION = 0.95
const FLOOR_FRICTION = 0.85

const BASE_GRAVITY = 10
const MAX_TERM_VEL = 900 

export var gravmult = 1.0
export var gravity_enabled = true
export var friction_enabled = true
export var gravity_only_when_not_on_floor = true


onready var e = get_parent()
var term_vel = MAX_TERM_VEL
var actual_air_fric = AIR_FRICTION


func _physics_process(delta):
	if not ("velocity" in e):return
	
	if gravity_enabled:
		
		if not gravity_only_when_not_on_floor or (e.has_method("is_on_floor") and !e.is_on_floor()):
			#if e.has_method("is_on_floor") and e.is_on_floor() or not gravity_only_on_floor:
			e.velocity.y = clamp(e.velocity.y + (BASE_GRAVITY * gravmult)*Engine.time_scale, -INF, (term_vel) )
		
	
	if friction_enabled:
		floor_friction()
		air_friction()




func floor_friction():
	if e.has_method("is_on_floor") and e.is_on_floor():
		e.velocity.x *= FLOOR_FRICTION
		return

func air_friction():
	e.velocity.x *= actual_air_fric
	



func _on_WallSlide_entered():
	gravmult = .25
	term_vel = 40
	


func _on_WallSlide_exited():
	gravmult = 1
	term_vel = MAX_TERM_VEL
