extends PhysicsStuff

export var affects_speed = false


func air_friction():
	e.velocity *= AIR_FRICTION
	if affects_speed:
		e.speed *= AIR_FRICTION
	
	
