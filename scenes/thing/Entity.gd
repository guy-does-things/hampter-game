extends Entity


var zipline :Line2D
var player : Entity

var ypos = 0


func _physics_process(delta):
	if player and player.is_on_floor():
		teleport_plr(player)
		
		if not is_instance_valid(zipline):return
		
		if $DirComp.current_dir.x == 0:return
		
		var point = zipline.points[0 if $DirComp.current_dir.x < 0 else 1]
		
		$WallCheck.cast_to.x = $DirComp.current_dir.x * 37
		if $WallCheck.is_colliding():return
		global_position.x += (250*$DirComp.current_dir.x) * delta
		

		

		
		
	if player:player.on_p = player.is_on_floor()


func teleport_plr(plr):
	#print_debug(global_position)
	plr.global_position = global_position + Vector2.DOWN * 14
	plr.velocity.x = 0


func _on_Area2D_body_entered(body:Entity):
	if body and body.is_in_group("player"):
		player = body

func _on_Area2D_body_exited(body):
	if !is_instance_valid(player):return
	
	if body == player:
		player = null
		body.on_p = false
		
