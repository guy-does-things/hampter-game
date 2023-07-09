#tool
class_name NewPlayerDetector
extends Area2D

signal target_detected(target)
signal target_invisible(target)

export(String) var target_group := "player"
export(String) var ally_group := "enemy"
export(bool) var cantaimY = false


onready var space_state := get_world_2d().direct_space_state
var target : Area2D
var last_target
var lineparent := Node.new()
var line := Line2D.new()


func _ready():
	collision_mask = 16
	
	#collision_layer = 16
	
	
	add_child(lineparent)
	lineparent.add_child(line)
	monitorable = false
	if is_connected("area_entered",self,"_on_Area2D2_area_entered"):return
	
	connect("area_entered",self,"_on_Area2D2_area_entered")



func _physics_process(delta):
	
	if is_instance_valid(target):
		var targetpos := Vector2(
			target.global_position.x,global_position.y
		)
		
		var visib_check_data = target_visib_check(target,cantaimY)
		var result = visib_check_data[1]
		line.visible = false
		line.points = [global_position,visib_check_data[0]]
		if result.empty():return
		
		if result.get("collider") == target:
			last_target = target
			emit_signal("target_detected",target)		
			#target = null
		else:
			emit_signal("target_invisible",target)

func target_visib_check(tget,cannotmovey):

	var targetpos = Vector2(
		tget.global_position.x,
		global_position.y if cannotmovey else tget.global_position.y 
	)

	var result = space_state.intersect_ray(
		global_position,
		targetpos, 
		get_tree().get_nodes_in_group(ally_group) + get_tree().get_nodes_in_group("hitbox"),
		16 | 4
		,true,true
	)
	
	return [targetpos if result.empty() else result.position,result]


	
		
func _on_Area2D2_area_entered(area):


	if (area.is_in_group(target_group) and 
		true and
		#area != last_target and 
		!area.is_in_group("hitbox")
	):
		target = area

