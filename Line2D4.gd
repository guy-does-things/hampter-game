tool
class_name Pipe
extends Line2D



var player :Entity
var moveindex :int
var dir :int
var cooldown = Timer.new()


func _ready():
	if points.size() < 2:
		queue_free()
		return

	# the timer is to avoid you getting sucked immediatly after reaching the end	
	add_child(cooldown)
	cooldown.one_shot = true
	cooldown.wait_time = .2
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(width,width) / 2
	
	
	
	for i in [0,points.size()-1]:
		var a = Area2D.new()
		var s = CollisionShape2D.new()
		
		#a.global_position = Vector2.ZERO#global_position + points[i]
		add_child(a)
		s.position = points[i]# + shape.extents / 2
		s.shape = shape
		a.add_child(s)
		a.connect("body_entered",self,"player_entered",[i, 1 if i == 0 else -1])


func _physics_process(delta):
	begin_cap_mode = 1
	end_cap_mode = 1
	
	
	if is_instance_valid(player):
		var point = to_global(points[moveindex])
		
		
		
		var dist = player.global_position.distance_to(
			to_global(points[moveindex])
		)
		
		var shootdir = player.global_position.direction_to(point)
		
		player.global_position = player.global_position.linear_interpolate(point,3 / dist)
		
		if dist < 3:moveindex += dir
		
		if moveindex > points.size()-1 or moveindex < 0:
			player.end_moving_on_tube()
			cooldown.start()
			player.velocity = shootdir *200
		
			
			player = null
			
		
		
		

		



func player_entered(plr,index,movedir):
	if not cooldown.is_stopped():return
	
	if plr.is_in_group("player") and not plr.is_riding():
		player = plr
		moveindex = index
		player.start_moving_in_tube()	
		dir = movedir	
		
		
	
