tool
extends EnemySpawner

export(String) var bossn



var room_data : RoomSaveInfo
var index : int = -1 setget set_index; func set_index(i):if index == -1:index = i


func spawn_enemy(_player, room):
	if not Engine.editor_hint:return false
	
	return .spawn_enemy(_player,room)


func setup_interaction_status(index,status:bool,is_load_game:bool):
	if not is_load_game:return
	
	if not status:
		instance_enemy()
		




func instance_enemy():
	.instance_enemy()
	Signals.emit_signal("boss_spawned",enem,bossn)
