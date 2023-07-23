tool
extends Sprite

var t = 0
var cindex = 0
const ROT = (PI/4)

var is_cross = false

var lt :Timer

const COLORS = [
	Color.white,
	Color(1000,1000,1000)
]

var colindex = 0

func _physics_process(delta):
	t += delta * Engine.time_scale * 5
	offset.y = sin(t)
	
	
#func _ready():
#	_on_LifeTimer_timeout()


func _on_LifeTimer_timeout():
	for i in range(8):
		if bool(i % 2) == is_cross:
			cindex = i
			var d = Vector2.RIGHT.rotated(ROT*cindex)
			
			$Node2D.deal_with_dir(d)
			$Node2D.try_shooting()
		
	get_parent().queue_free()


func _on_Node2D_proj_created(proj):
	proj.rotation = ROT*cindex


func _on_GdtBullet_startup(bullet:GdtBullet):
	lt = bullet.life_timer
	is_cross = bullet.customdata.get("is_cross",is_cross)
	frame = int(is_cross)
	var nt :Timer= bullet.life_timer.duplicate()
	nt.wait_time *= .25
	nt.one_shot = false
	nt.autostart = true
	nt.connect("timeout",self,"ft_timeout")
	add_child(nt)
	$Node2D.is_enemy = bullet.is_enemy


func ft_timeout():
	colindex += 1
	
	modulate = COLORS[colindex%2]

