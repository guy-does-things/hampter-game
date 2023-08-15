extends NewestRoom


var c :Camera2D
var e = null

func _ready():
	if SavesManager.current_save.global_data.get("car_scenario"):teslasetup()


func teslasetup():
	$StaticBody2D2/CollisionShape2D.disabled = false
	

func _on_Area2D_body_entered(body):
	e = body
	if SavesManager.current_save.global_data.get("car_scenario"):return
	teslasetup()
	body.velocity *= 0
	for i in get_children():
		if i is EnemySpawner:
			if is_instance_valid(i.enem):
				i.enem.get_node("HurtComponent").hurt(3132123,Vector2.ZERO,0,false,512)
	

	c = body.get_node("RoomBasedCamera")
	Globals.can_open_menu = false
	c.global_position = $Position2D.global_position
	yield(get_tree().create_timer(1.0,false),"timeout")
	$AnimationPlayer.play("carcrash")


func on_cars():
	SavesManager.current_save.global_data.car_scenario = true
	
	var d = NewRoomAutoload.get_data_from_packedscene(preload("res://locations/nitrotasticman/car_jumpscare_3_electric_bogaloo.tscn"))
	NewRoomAutoload.load_room(d)
	
	e.global_position = NewRoomAutoload.room_stack[NewRoomAutoload.data_stack.find(d)].get_node("Psp").global_position
	
	
	c.position = Vector2.ZERO
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	Globals.can_open_menu = true
