extends "res://boss.gd"

signal is_gonna_fire()

var dir = Vector2.ZERO
var previous_stone_frame = 0
var is_cross = false

export var distmult = 2.5

var outline_colors =[
	Color.black,
	Color.white,
	Color.red,
	Color.orangered
	
]
export var o_color = 0.0 setget set_ocolor; func set_ocolor(val):
	if not is_inside_tree():return
	
	o_color = val
	$Flippables/Bootlegeo.material.set_shader_param("rep_col",outline_colors[int(o_color)%4])


func do_rock_attack(d):
	Signals.emit_signal("screenshake",Vector2.DOWN,32)
	for i in [0,1,2,3.5]:
		var stone = preload("res://bullets/rockandstone.tscn").instance()
		stone.damage = 5
		stone.is_enemy = true
		stone.global_position = global_position# + (dir * 16)# + (Vector2.UP *5)
		
		stone.velocity = d *100
		stone.velocity -= Vector2.RIGHT.rotated(rotation) * (150*i)
		#* (100 + (150*i))
		stone.lifetime =2
		
		previous_stone_frame += 1
		previous_stone_frame %= 2
		if i != 0:
			stone.customdata.frame = previous_stone_frame

		
		stone.get_data().deletes_on_wall = false
		get_tree().current_scene.add_child(stone)
		stone.get_data().deletes_on_wall = false




func _on_SpitGun_proj_created(proj):
	proj.speed = global_position.distance_to($"%StatusThing".target.global_position) * distmult
	proj.customdata["is_cross"] =is_cross
	is_cross = !is_cross
	


func _on_SpitGun_fullypoweredup(gun):
	emit_signal("is_gonna_fire")
	$FiringDelay.start()
	yield($FiringDelay,"timeout")
	$Flippables/Bootlegeo.frame = 2
	$SpitGun.stop_firing()


func _on_SpitGun_charging(gun):
	$Flippables/Bootlegeo.frame = 4


func _on_SpitGun_funnyrecoil(dir, inte):
	velocity -= dir * inte
