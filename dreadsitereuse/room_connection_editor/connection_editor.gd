extends Control


const data = preload("res://room_dict_data.tres")
var graph_dictionary := {
	"name":{},
	"scene":{}
}

var arealabel := Label.new()
var view_button := Button.new()
var current_node : RoomNode

signal start_room_view(room_node)

# adds every node, also makes the screen freely scalable
func _ready():
	Globals.IS_EDITOR = true
	view_button.text = "VIEW ROOM"
	arealabel.text = "ROOM NOT SELECTED"
	view_button.connect("pressed",self,"view_room")
	#arealabel.add_font_override("font", preload("res://fonts/font.tres"))
	$"%GraphEdit".get_zoom_hbox().add_child(arealabel)
	$"%GraphEdit".get_zoom_hbox().add_child(view_button)
	
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE,Vector2(480,270))
	
	for i in range(data.room_data_dict.values().size()):
		
		var room_data = data.room_data_dict.values()[i]
		
		var n = preload("room_node.tscn").instance()
		$"%GraphEdit".add_child(n)
		n.setup(room_data,i)
		
		graph_dictionary.name[n.name] = n
		graph_dictionary.scene[n.data.room_scene] = n
		
	for con in data.connection_editor_connections:
		var _e = $"%GraphEdit".connect_node(con.from, con.from_port, con.to, con.to_port)
	



func _physics_process(delta):
	if Input.is_physical_key_pressed(KEY_S) and Input.is_physical_key_pressed(KEY_CONTROL):
		data.connection_editor_connections = $"%GraphEdit".get_connection_list()

		
		var result = ResourceSaver.save(data.resource_path,data)
		
		if result == OK:
			print("SAVED!")
		else:
			print("ERROR:",result)




func _on_GraphEdit_connection_request(from:String, from_slot, to:String, to_slot):
	var nodea :RoomNode= graph_dictionary.name.get(from)
	var nodeb :RoomNode= graph_dictionary.name.get(to)
	
	if not (nodea.can_connect(from_slot) and nodeb.can_connect(to_slot)):return

	nodea.set_connection_scene(from_slot,nodeb.get_scene())
	nodeb.set_connection_scene(to_slot,nodea.get_scene())
	
	
	$"%GraphEdit".connect_node(from,from_slot,to,to_slot)
	
	


func _on_GraphEdit_disconnection_request(from, from_slot, to, to_slot):
	var nodea :RoomNode= graph_dictionary.name.get(from)
	var nodeb :RoomNode= graph_dictionary.name.get(to)
	
	
	nodea.set_connection_scene(from_slot,null)
	nodeb.set_connection_scene(to_slot,null)
	
	
	
	$"%GraphEdit".disconnect_node(from,from_slot,to,to_slot)


func _on_GraphEdit_node_selected(node):
	current_node = node


func _on_GraphEdit_node_unselected(node):
	if node != current_node:
		return
	
	
	arealabel.text = "ROOM NOT SELECTED\n"





func view_room():
	if not current_node:return
	emit_signal(
		"start_room_view",current_node
	)







