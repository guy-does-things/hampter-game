class_name Entity
extends KinematicBody2D


var velocity : Vector2
var can_slide = true

func _physics_process(delta):
	try_move()

func try_move():
	if can_move():
		move()


func can_move():
	return not(get("motion/sync_to_physics") or not can_slide)

func move():
	velocity = move_and_slide(velocity,Vector2.UP)



func local_freeze(fstatus:bool,freeze_root:bool):
	freeze_node_and_children(self,fstatus,freeze_root)



func freeze_node_and_children(node:Node,status:bool,should_freeze_root:bool):
	var cstatus := status
	
	if node == self and !should_freeze_root:
		cstatus = false
	
	if node.name == "Ptest":return
	node.set_process(!cstatus)
	node.set_process_internal(!cstatus)
	node.set_physics_process(!cstatus)
	node.set_physics_process_internal(!cstatus)
	
	
	for i in node.get_children():
		freeze_node_and_children(i,status,true)
	
