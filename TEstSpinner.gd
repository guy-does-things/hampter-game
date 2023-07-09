extends KinematicBody2D

var rotating: int
var move : Vector2

func _physics_process(delta):
	$Wheelattack.rotation_degrees += 20
	
	if rotating:
		rotation = lerp_angle(rotation, move.angle(), 0.1)
		rotating -= 1
		return
	
	var col := move_and_collide(move * 50	 * delta)
	if col and col.normal.rotated(PI/2).dot(move) < 0.5:
		rotating = 4
		move = col.normal.rotated(PI/2)
		return
	
	var pos := position
	col = move_and_collide(move.rotated(PI/2) * 15)
	if not col:
		for i in 10:
			position = pos
			rotate(PI/32)
			move = move.rotated(PI/32)
			col = move_and_collide(move.rotated(PI/2) * 15)
			
			if col:
				move = col.normal.rotated(PI/2)
				rotation = move.angle()
				break
	else:
		move = col.normal.rotated(PI/2)
		rotation = move.angle()


# pleras read in the minos prime voice
func DIE(dam):
	var expl = preload("res://bullets/explosion/explosion.tscn").instance()
	expl.global_position = global_position
	expl.lifetime = .55
	expl.damage = 0
	get_tree().current_scene.add_child(expl)
	queue_free()
