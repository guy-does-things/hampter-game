extends VBoxContainer


class ItemToggle extends CheckBox:
	var item_data : ItemData
	var item_obtained = true
	var item_disabled = true
	
	
static func sort_item_toggles(ita:ItemToggle,itb:ItemToggle):
	return ita.item_data.item_id < itb.item_data.item_id

# Called when the node enters the scene tree for the first time.
func _ready():
	var item_buttons = []
	
	for item in Globals.item_data:
		var it = ItemToggle.new()
		it.item_data = item
		it.text = item.item_name
		item_buttons.append(it)
		it.pressed = true
		it.connect("focus_entered",self,"toggle_hovered",[it])
	item_buttons.sort_custom(
		self,
		"sort_item_toggles"
	)

	var button_grid := {}
	var current_button_pos_thing : Vector2

	for it in item_buttons:
		if current_button_pos_thing.x > 1:
			current_button_pos_thing.y += 1
			current_button_pos_thing.x = 0
			
		button_grid[current_button_pos_thing] = [it,it.get_path()]
		$ItemButtonContainer/GridContainer.add_child(it)
		
		current_button_pos_thing.x += 1
	
	
	for i in button_grid.keys():
		var pos :Vector2 = i
		var toggle : ItemToggle = button_grid[i][0]
		toggle.focus_neighbour_top = get_neighbor_in_dir(button_grid,Vector2.UP,pos,toggle)
		toggle.focus_neighbour_bottom = get_neighbor_in_dir(button_grid,Vector2.DOWN,pos,toggle)	
		
		toggle.focus_neighbour_left = get_neighbor_in_dir(button_grid,Vector2.LEFT,pos,toggle)
		toggle.focus_neighbour_right = get_neighbor_in_dir(button_grid,Vector2.RIGHT,pos,toggle)



	$ItemButtonContainer/GridContainer.connect_focus_signals()


func get_neighbor_in_dir(
	neighbors:Dictionary,
	dir:Vector2,
	pos:Vector2,
	toggle:ItemToggle
)->String:
	return neighbors.get(pos+dir,[toggle,toggle.get_path()])[1] as String



func toggle_hovered(toggle:ItemToggle):
	$VBoxContainer/name.text = toggle.text
	$VBoxContainer/desc.text = toggle.item_data.item_desc


func selected():
	show()
	$ItemButtonContainer/GridContainer.get_child(0).grab_focus()


func deselect():hide()

