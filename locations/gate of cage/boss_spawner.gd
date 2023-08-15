tool
class_name BossSpawner
extends EnemySpawner

export(String) var bossn



var room_data : RoomSaveInfo
var index : int = -1 setget set_index; func set_index(i):if index == -1:index = i
var ssent = false
signal start_enc()
signal boss_ded()
export var spawn_regardless = false




func spawn_enemy(_player, room):
	if not Engine.editor_hint:return false
	return .spawn_enemy(_player,room)

func del_enemy(_player, room):
	return
	if is_instance_valid(enem) and room != get_parent():
		enem.queue_free()


func setup_interaction_status(index,status:bool,is_load_game:bool):
	

	if status:
		room_data.modify_pickup_flag(self.index, true)
		if not spawn_regardless:
			return


	if not is_load_game:
		return
	
	
	instance_enemy()
		




func instance_enemy():
	.instance_enemy()
	
	
		

	
	


func _on_Area2D_body_entered(body):
	if is_instance_valid(enem) and not ssent:
		ssent = true
		emit_signal("start_enc")
		Signals.emit_signal("boss_spawned",enem,bossn)
	
