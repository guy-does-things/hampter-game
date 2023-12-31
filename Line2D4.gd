tool
class_name Pipe
extends Line2D



var player :Entity
var moveindex :int
var dir :int
var cooldown = Timer.new()
export var extra_speed := 0


func _ready():
	extra_speed = 4
	
	z_index = 2
	width = 32
	default_color = Color.white
	if Engine.editor_hint:return
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
		var sob = StaticBody2D.new()
		var s = CollisionShape2D.new()
		
		#a.global_position = Vector2.ZERO#global_position + points[i]
		add_child(a)
		add_child(sob)
		a.add_to_group("pipe")
		s.position = points[i]# + shape.extents / 2
		s.shape = shape
		sob.collision_layer = 8
		sob.collision_mask = 8
		
		a.add_child(s)
		a.connect("body_entered",self,"player_entered",[i, 1 if i == 0 else -1])
		sob.add_child(s.duplicate())
		

func _physics_process(delta):
	begin_cap_mode = 1
	end_cap_mode = 1
	texture_mode = 1
	texture = preload("res://raw_sprites/hamptertube.png")
	
	if is_instance_valid(player):
	
		var point = to_global(points[moveindex])
		
		
		
		var dist = player.global_position.distance_to(
			to_global(points[moveindex])
		)+.000001
		
		var shootdir = player.global_position.direction_to(point)
		
		var speed = 3+extra_speed
		
		
		player.global_position = player.global_position.linear_interpolate(point,speed / dist)
		
		if dist < 3.01+extra_speed:moveindex += dir
		
		if moveindex > points.size()-1 or moveindex < 0:
			player.last_walk_dir = sign(shootdir.x)
			player.end_moving_on_tube()
			cooldown.start()
			player.velocity = shootdir *200
			player = null



func player_entered(plr,index,movedir):
	if not cooldown.is_stopped():return false
	
	if plr.is_in_group("player") and not plr.is_riding():
		player = plr
		moveindex = index
		player.start_moving_in_tube()	
		dir = movedir
		on_riding(plr,index,movedir)
		return true
	
	return false
		
		
func on_riding(plr,index,movedir):
	pass	
		
	
