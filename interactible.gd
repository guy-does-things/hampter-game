tool
class_name Interactible
extends Area2D
signal can_interact()
signal exited()
signal interacted()

export var debug = false
export var save_interaction_state = false
export var is_toggle  = false
export var subgroup = "defautsubgroup"
var can_interact = true
var interacted = false
var plr : Entity
var loaded_save = false

var instance_id : int


func _init():
	if !Engine.editor_hint:
		add_to_group(subgroup)
		add_to_group("interactible")
		connect("body_entered",self,"_on_Area2D_body_entered")
		connect("body_exited",self,"_on_Area2D_body_exited")


func _ready():
	instance_id = get_tree().get_nodes_in_group(subgroup).find(self)
	
	if save_interaction_state and !Engine.editor_hint:
		load_interact_state(
			SavesManager.current_save.get_thing_interaction_status(subgroup,instance_id)#things_interacted.get(get_tree().get_nodes_in_group("interactible").find(self),false )
		)

	
func load_interact_state(nis :bool):
	if not nis and not is_toggle:
		loaded_save = true
		return 

	interacted = nis
	interact(nis,true)



func _on_Area2D_body_entered(body):
	
	if body.is_in_group("player"):
		emit_signal("can_interact")
		#$Node2D.show()
		plr = body
		#print_debug("why")


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		emit_signal("exited")
		plr = null
		
		
func _process(delta):
	try_interacting()
	
	
func try_interacting():
	if !Engine.editor_hint and !Globals.console_opened:
		if Input.is_action_just_pressed("interact") and plr:
			interact(interacted,false)


func interact(cinteractionstatus,nosave)-> void:
	if can_interact:
		
		if !nosave:
			interacted = set_interaction_status(cinteractionstatus)
		
		emit_signal("interacted")
		if save_interaction_state and !nosave:
			save_interaction()
		
		
		loaded_save = true


func set_interaction_status(istat : bool):
	if is_toggle:
		return !istat
	return true
	
	
func save_interaction():
	SavesManager.current_save.thing_interacted_with(subgroup,instance_id, interacted)
	


func _on_Interactible_interacted():
	#print_debug("???")
	interact(interacted,false)
