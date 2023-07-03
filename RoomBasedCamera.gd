extends Camera2D

var __not_entered_anything = true

var __border_offset :Vector2
var locks_to_room = true
var current_room_rect : Rect2


func _ready():
	Signals.connect("screenshake",self,"shake_to_dir")
	Signals.connect("position_screenshake",self,"shake_based_on_position")
	
	Signals.connect("player_entered_room",self,"player_entered_room")
	#CommandHandler.connect("camera_room_lock_modified",self,"changed_room_lock_status")


func changed_room_lock_status(status):
	locks_to_room = status
	if !status:
		remove_limits()
	
	

func player_entered_room(player, room :NewestRoom):
	if player != get_parent():
		return
		
	var rect:Rect2 = room.roomrect.get_global_rect()
	transition(rect)


func transition(map_limits : Rect2):
	current_room_rect = map_limits
	
	if !locks_to_room:
		remove_limits()
		return

	
	if locks_to_room:
		set_limits(map_limits)
	else:
		remove_limits()
	__not_entered_anything = false


func set_limits(map_limits : Rect2):
	limit_left = map_limits.position.x 
	limit_right = map_limits.end.x 
	limit_top = map_limits.position.y
	limit_bottom = map_limits.end.y


func remove_limits():
	limit_left = -10000000
	limit_right = -limit_left
	limit_top = limit_left
	limit_bottom = limit_right


func shake_based_on_position(pos, inte : float):
	shake_to_dir(
		get_camera_screen_center().direction_to(pos),inte
	)

func shake_to_dir(dir : Vector2, inte : float):
	offset -= dir.normalized() * (inte)# * SavesManager.settings.screenshake) 


func _physics_process(delta):
	offset -= offset.linear_interpolate(Vector2.ZERO, .8) 
	
