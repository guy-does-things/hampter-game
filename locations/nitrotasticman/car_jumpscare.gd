extends NewestRoom

const SPAWNDELAY = .9

var max_birbs = 5
var birbs := []

var t = 0
var side = -1
var p 

func _ready():
	Signals.connect("player_entered_room",self,"_on_player_entered_room")

func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() != 0:
		t = 0
		return
	
	if t >= SPAWNDELAY:
		spawn_birb()
		t = 0
		
	t+= delta
		
func _on_player_entered_room(plr,room):
	p = plr
		
func spawn_birb():
	side *= -1
	
	if not MapManager.current_room_in == self:
		for i in birbs:i.queue_free()
		return	
		
	if not is_instance_valid(p):return
	if birbs.size() >= max_birbs:return

	var transorigin = get_viewport_transform().origin
	var birb = preload("res://scenes/enemies/birb/paloma.tscn").instance()
	transorigin.x += 10
	
	if side == -1:
		transorigin.x -= 500
	
	birb.global_position = -transorigin
	birb.global_position.y =p.global_position.y
	birb.side = side
	get_tree().current_scene.add_child(birb)
	birbs.append(birb)
	birb.connect("tree_exiting",self,"birbdie",[birb])
	
	
	
func birbdie(birb):
	birbs.erase(birb)
	
	
