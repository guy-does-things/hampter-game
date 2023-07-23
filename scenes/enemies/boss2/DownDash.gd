extends State


const MAX_DASHES = 3
var dashes = 0
var diry = 1
var enemyspawned = false


func _enter_state(new,o):
	$"%SwimBox".monitoring = true
	$"%Flippables".disabled = true
	$"%Flippables".is_moving_y = true
	._enter_state(new,o)
	start_timer()

func start_timer():
	#print(dashes,MAX_DASHES)
	
	if dashes > MAX_DASHES:
		$Timer.stop()
		return
	enemyspawned = false
	$Timer.start()
	diry *= -1


func spawn_efish():
	var m = preload("res://scenes/enemies/toxic_fish_minions/fish_minion.tscn").instance()
	
	m.global_position = entity.global_position
	m.target = $"%StatusThing".target
	
	get_tree().current_scene.add_child(m)
	
	
func _get_transition(dt):
	
	if dashes > MAX_DASHES:
		return $"%Delay"
		

func _exit_state(o,n):	
	$"%Flippables".is_moving_y = false
	$"%Flippables".disabled = false
	._exit_state(o,n)
	yield(get_tree().create_timer(.15,false),"timeout")
	$"../../CollisionShape2D".disabled = false
	dashes = 0
	
	
# Called when the node enters the scene tree for the first time.
func _state_logic(delta):
	var room :NewestRoom= MapManager.current_room_in
	if not $"%StatusThing".target:return
	if not room:return
	var rrect :Rect2 = room.roomrect.get_global_rect()
	
	$"%Flippables".flip(-diry)
	
	if dashes > MAX_DASHES:
		set_ypos(rrect)
		entity.velocity.y = diry * 400
		return
	
	
	
	
	if $Timer.is_stopped():
		entity.velocity.y = diry * 384
		if abs(rrect.get_center().y - entity.global_position.y) < 64 and not enemyspawned:
			spawn_efish()
			enemyspawned = true
		
		
		if not $"%DummyRect".get_global_rect().intersects(rrect) and $DashResetDelay.is_stopped():
			$DashResetDelay.start()
		
		return
	
	
		
	


	if $Timer.time_left >= .5:
		set_ypos(rrect)
		entity.global_position.x = $"%StatusThing".target.global_position.x
	
		$"%Nukingisnowlegal".enable = true
		$"%Line2D".points = [
			Vector2.ZERO,
			Vector2.UP*(rrect.size.y-64)
		]
		
		$"%Nukingisnowlegal".show()
		$"%Nukingisnowlegal".global_position.x = entity.global_position.x - 16
		$"%Nukingisnowlegal".global_position.y = (rrect.end.y -48) - 16


func set_ypos(rrect:Rect2):
	if diry == 1:
		entity.global_position.y = rrect.position.y 
	else:
		entity.global_position.y = rrect.end.y




func _on_Timer_timeout():
	
	$"%Nukingisnowlegal".hide()
	$"%Nukingisnowlegal".enable = true


func _on_DashResetDelay_timeout():
	dashes += 1
	start_timer()
