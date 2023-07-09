extends Sprite

export var damage = 10
var has_explded = false

func _on_GdtBullet_collided(type, bul:GdtBullet, collider):
	if (type == bul.Colliders.ALLY or bul.damage == 0):return

	if has_explded:return
	has_explded = true
	
	
	var expl = preload("res://bullets/explosion/explosion.tscn").instance()
	expl.is_enemy = bul.is_enemy
	expl.global_position = global_position
	expl.lifetime = .55
	expl.damage = damage
	get_tree().current_scene.add_child(expl)
	bul.queue_free()



func _physics_process(delta):
	rotation += ((PI*2) * delta)*6
