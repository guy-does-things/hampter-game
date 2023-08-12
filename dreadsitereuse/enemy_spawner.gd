tool 
class_name EnemySpawner
extends Position2D

export(PackedScene) var enemy setget set_enemy

var enem = null

signal spawned


func _ready():
	if !Engine.editor_hint:
		Signals.connect("player_entered_room",self, "spawn_enemy")
		Signals.connect("player_entered_room",self, "del_enemy")
	set_enemy(enemy)


func set_enemy(new_enemy):
	enemy =new_enemy
	if Engine.editor_hint:
		if is_instance_valid(enem):
			enem.free()
		
		instance_enemy()
		
		
		
		
func spawn_enemy(_player, room):	
	if not SavesManager.current_save.global_data.get("holyshitfnaf"):return false
	
	if !is_instance_valid(enem) and room == get_parent():
		instance_enemy()	
		emit_signal("spawned")
		return true
	return false
	
func del_enemy(_player, room):
	
	if is_instance_valid(enem) and room != get_parent():
		enem.queue_free()



func instance_enemy():
	if enemy:
		enem = enemy.instance()
		enem.position = Vector2.ZERO
		call_deferred("add_child",enem)
		
