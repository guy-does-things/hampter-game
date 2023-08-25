tool
extends Area2D

signal can_interact()
signal exited()
signal interacted(istatus)


export var keyprompt_offset :Vector2
export(NewSaveData.Areas) var aria_of_interactible
export var is_toggle : bool
var plr : Entity
var interacted : bool 
var kprompt = preload("res://keypromp/kprompt.tscn").instance()


func _init():
	collision_layer = 0
	collision_mask = 1<<7
	connect("body_entered",self,"_body_entered")
	connect("body_exited",self,"_body_exited")

func _ready():
	kprompt.hide()
	add_child(kprompt)

func _body_entered(body):
	emit_signal("can_interact")
	plr = body
	kprompt.rect_position = keyprompt_offset - (kprompt.rect_size / 2)
	kprompt.show()

func _body_exited(body):
	emit_signal("exited")
	plr = null
	kprompt.hide()
		

func _draw():
	if Engine.editor_hint:
		draw_rect(Rect2(keyprompt_offset-Vector2(4,4),Vector2(8,8)),Color("b00b69"))


func _physics_process(delta):
	try_interacting()

func _process(delta):
	if Engine.editor_hint:
		update()
	
		
	
func try_interacting():
	if (Engine.editor_hint):return

	if Input.is_action_just_pressed("interact") and plr:
		interact(interacted)


func interact(cinteractionstatus,is_loading_game:=false)-> void:
	interacted = set_interaction_status(cinteractionstatus)
	emit_signal("interacted",interacted)
	

func set_interaction_status(istat : bool):
	if is_toggle:return !istat
	return true



  
