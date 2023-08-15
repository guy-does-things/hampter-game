extends "res://dreadsitereuse/nsio/msiotest.gd"


export var speed = 32.0
var invisible = true
var can_fast_travel := false
var can_do_tp_input = false
var can_move_cursor = false
var zoom = 1 setget set_zoom

signal fast_travel(save_point)

func set_zoom(nz):
	zoom = nz
	$Camera2D.zoom = Vector2.ONE * 1.0/zoom

func move_cam():
	
	
	if invisible:
		.move_cam()
		return
	
	if not can_move_cursor:return

	cam.position += $"%Dcomp".current_dir*(speed/zoom)


func set_inv(inv):
	invisible = inv

func _on_Panel2_minimize_request(window, is_ctrinput):
	invisible = true

func can_do_tp_input():
	yield(get_tree().create_timer(.2),"timeout")
	can_do_tp_input = true
	


func _physics_process(delta):
	var overlapping = false
	
	var overlapped_point := waypoint.try_intersecting(cam.get_camera_screen_center())
	
	if not invisible :
		for i in save_points:
			var c :SaveSprite= i
			
			var result = c.try_intersecting(cam.get_camera_screen_center())
			if result:
				overlapping = result
			
			if result and (can_do_tp_input and can_fast_travel):			
				if Input.is_action_just_pressed("ui_accept"):
					emit_signal("fast_travel",c)
					can_fast_travel = false
					can_do_tp_input = false
					return


		if Input.is_action_just_pressed("ui_accept") and !overlapping:
			
			var point_position := cam.get_camera_screen_center() - Vector2(2,2)
			
			if overlapped_point:
				point_position = Vector2.INF
	
			SavesManager.current_save.waypoint_position = point_position
			Signals.emit_signal("waypoint_moved")			
			return



func update_wp():
	SavesManager.current_save.waypoint_position = $Camera2D/Yoyoprojtest.global_position
	waypoint_info_changed()
