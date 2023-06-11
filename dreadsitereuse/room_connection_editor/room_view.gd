extends Control


var instanced_room : NewestRoom





func _on_Control_start_room_view(room_node:RoomNode):
	if is_instance_valid(instanced_room):return
	instanced_room = room_node.get_scene().instance()
	$"%Viewport".add_child(instanced_room)
	
	instanced_room.global_position = -instanced_room.get_node("RoomRect").get_global_rect().get_center()
	show()
	

func _on_Button_pressed():
	hide()
	if is_instance_valid(instanced_room):instanced_room.queue_free()
