extends Sprite



var room_data : RoomSaveInfo
var index : int = -1 setget set_index; func set_index(i):if index == -1:index = i



func setup_interaction_status(index,status:bool,is_load_game:bool):
	interact(status,is_load_game)


func interact(cinteractionstatus:bool,is_loading_game:=false)-> void:
	if cinteractionstatus:enabled(is_loading_game)
	
	if !is_loading_game:
		room_data.pickups[index] = cinteractionstatus
		


func enabled(loadingame):
	if $Area2D:
		$Area2D.queue_free()
		material = null
		if not loadingame:
			SavesManager.current_save.global_data.seals = SavesManager.current_save.global_data.get("seals",0) +1
			$AudioStreamPlayer.play()
			$CPUParticles2D.emitting = true

		

func _on_Area2D_body_entered(body):
	enabled(false)
