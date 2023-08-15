extends Area2D

export(GlobalData.Items) var item_to_give = 1


var index :=0
var room_data :RoomSaveInfo

func setup_interaction_status(index,is_enabled,is_save):
	
	room_data.pickups[index] = is_enabled
	if is_enabled:
		opened()



func opened():
	$Chest.frame = 1
	$CollisionShape2D.disabled = true
	collision_layer = 0
	collision_mask =0
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		
		var sc :StatusThing= body.get_node_or_null("StatusThing")
		
		if not sc:return
		room_data.modify_pickup_flag(index, true) 
		opened()
		
		sc.unlocked_item(item_to_give)
