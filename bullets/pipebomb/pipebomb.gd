extends Sprite

export var damage = 10
var has_explded = false

func _on_GdtBullet_collided(type, bul:GdtBullet, collider):
	if (type == bul.Colliders.ALLY or bul.damage == 0):return

	if has_explded:return
	has_explded = true
	
	var non_internal_groups = []
	for group in bul.get_groups():
		if not group.begins_with("_"):
			non_internal_groups.push_back(group)

	
	var expl = preload("res://bullets/explosion/explosion.tscn").instance()
	expl.is_enemy = bul.is_enemy
	expl.global_position = global_position
	expl.lifetime = .55
	expl.damage = damage
	
	for group in non_internal_groups:expl.add_to_group(group)
	print(expl.get_groups())
	
	get_tree().current_scene.add_child(expl)
	bul.queue_free()



func _physics_process(delta):
	rotation += ((PI*2) * delta)*6
