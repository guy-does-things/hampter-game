tool
class_name WaterFall
extends ColorRect

export var particle_count = 32


func _physics_process(delta):
	$"%CPUParticles2D".position = Vector2(rect_size.x / 2,rect_size.y)
	$"%CPUParticles2D".emission_rect_extents.x = rect_size.x /2
	
	if $"%CPUParticles2D".amount != particle_count:
		$"%CPUParticles2D".amount = particle_count
