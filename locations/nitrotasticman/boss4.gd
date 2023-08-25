extends "res://locations/gate of cage/bossroom.gd"



var e : Node2D


func _ready():
	Signals.connect("player_entered_room",self,"_on_player_entered_room")
	

func _on_player_entered_room(player, room):
	e = player		

func _on_EnemySpawner_boss_ded(start):
	
	if ._on_EnemySpawner_boss_ded(start):
		$CanvasLayer/ColorRect.show()
		$AnimationPlayer.play("transiti")
		
func telepor():
	var d = NewRoomAutoload.get_data_from_packedscene(preload("res://locations/lecastlevania/castle_entrance.tscn"))
	NewRoomAutoload.load_room(d)
	e.global_position = d.room_position + Vector2(256,216)
