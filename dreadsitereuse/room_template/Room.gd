class_name NewestRoom
extends Node2D

signal setup(data)

onready var roomrect = $RoomRect

#SaveData.Areas
export(NewSaveData.Areas) var room_area 
var assigned_room_data 
var save_data : RoomSaveInfo

func _ready():
	if Engine.editor_hint:return
	#save_data = NewRoomAutoload.room_save_data.get(load(filename))



func setup(data):
	assigned_room_data = data
	emit_signal("setup",assigned_room_data)
	
	
	for i in data.transition_rooms.size():
		var next_room = data.transition_rooms[i]
		var trans_trigger :nTransitionTrigger= $Transitions.get_child(i)
		trans_trigger.set_room_to_load(next_room)
	
	
	for i in $Transitions.get_children():
		var cs := StaticBody2D.new()
		
		$Transitions.add_child(cs)
		$Transitions.remove_child(i)
		cs.add_child(i)
		cs.collision_mask = 0
		cs.collision_layer = 8192
	
	
	$RoomRect.rect_size = data.room_rect.size
	$RoomRect.rect_position = data.room_rect.position

	$RoomObjectManager.setup(NewRoomAutoload.room_save_data[data.room_scene])
		
	
	

func get_rect():
	return $RoomRect.get_global_rect()
	




func _on_Area2D_interacted(istatus):
	$Light2D.visible = istatus




func boom():
	var expl = preload("res://bullets/explosion/explosion.tscn").instance()
	expl.global_position = $Shittycar.global_position
	expl.lifetime = .55
	expl.damage = 0
	expl.scale *= 4
	get_tree().current_scene.add_child(expl)
	



