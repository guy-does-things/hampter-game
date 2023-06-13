tool
extends ReferenceRect

export var print_shit = false
export var size_mult := Vector2.ONE * .95

var rect_shape := RectangleShape2D.new()
var cs = CollisionShape2D.new()

var initialized = false
var a :=Area2D.new()
var last_e_state = false

signal princessevent(victim)
func _init():pause_mode = PAUSE_MODE_PROCESS

func _ready():
	setup_area()
	setup_shape()
	Signals.connect("player_entered_room",self,"_on_player_entered_room")
	#a.hide()


func _on_player_entered_room(player, room):
	var index = NewRoomAutoload.room_stack.find(get_parent())
	
	if index != 0:
		Signals.emit_signal("player_exited_room",get_parent())
	
	
func setup_shape():
	#print("WHY")
	rect_shape.extents = rect_size / 2
	rect_shape.extents *= size_mult
	initialized = true
	cs.shape = rect_shape
	if cs.get_parent() == null:
		a.add_child(cs)
	
	
func setup_area():
	if a.get_parent() == null:
		add_child(a)
	
	a.position = rect_size / 2
	(a as Area2D).monitorable = false
	(a as Area2D).collision_layer = 0
	(a as Area2D).collision_mask = 1<<7








func _physics_process(delta):
	if Engine.editor_hint:
		setup_area()
		setup_shape()
		return
	
	
	if !initialized :return

	
	
	
	
	var r = a.get_overlapping_bodies().size() > 0


#	if NewRoomAutoload.get_current_room() != get_parent() and last_e_state:
		#Signals.emit_signal("player_exited_room",get_parent())
#
#	last_e_state = r
	
	#if NewRoomAutoload.get_current_room() == get_parent() and MapManager.current_room_in == get_parent() or Globals.IS_EDITOR:
	get_parent().show()
	#	return
	#elif !r:
	#	get_parent().hide()

	
	
	if r:
		get_parent().show()		
		NewRoomAutoload.entered_room(get_parent(), get_parent().assigned_room_data)		
		
		if MapManager.current_room_in != get_parent():
			MapManager.current_room_in = get_parent()
			Signals.emit_signal("player_entered_room",a.get_overlapping_bodies()[0], get_parent())
