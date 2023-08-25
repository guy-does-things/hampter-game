tool
class_name BossSpawner
extends Position2D

export(String) var bossn

export(PackedScene) var enemy


var room_data : RoomSaveInfo
var index : int = -1 setget set_index; func set_index(i):if index == -1:index = i
var ssent = false
signal start_enc()
signal boss_ded()
export var spawn_regardless = false
var enem = null

func _ready(): 
	show()



func setup_interaction_status(index,status:bool,is_load_game:bool):
	print("load values on boss spawner",status,is_load_game)
	
	if status:
		print("should stop here unless boss rush")
		room_data.modify_pickup_flag(self.index, true)
		if not spawn_regardless:
			return


	if not is_load_game:
		print("should stop here at all")
		return
	
	print("contact me and send me this print if a boss respawns outside boss rush",is_load_game,status,spawn_regardless)
	
	
	instance_enemy()
	
	




func instance_enemy():
	if enemy:
		enem = enemy.instance()
		enem.position = Vector2.ZERO
		call_deferred("add_child",enem)
		#enem.get_node("StatusThing").current_hp = 0



func _on_Area2D_body_entered(body):
	if is_instance_valid(enem) and not ssent:
		ssent = true
		emit_signal("start_enc")
		Signals.emit_signal("boss_spawned",enem,bossn)
	
