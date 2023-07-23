extends VBoxContainer


var status :StatusThing setget set_status;

func set_status(sthing):
	status = sthing
	for child in $ItemButtonContainer/GridContainer.get_children():
		child.status = status

class ItemToggle extends CheckBox:
	var item_data : ItemData
	var item_obtained = false
	var item_disabled = true
	var status : StatusThing
	
	func _physics_process(delta):
		
		
		if !status:
			hide()
			return
		
		item_obtained = status.raw_hasitem(item_data.item_id)
		
		if !item_obtained:
			hide()
			return
		
		
		disabled = (
			item_data.item_id == Globals.Items.WATERBREATHING and status.on_water or
			item_data.item_id == Globals.Items.HPUP or
			item_data.item_id == Globals.Items.BLADEUP
		)
	
	func _toggled(button_pressed):
		if not status:return
		
		var index = GlobalData.item_to_id(item_data.item_id)
		
		if (button_pressed):
			status.disabled_bitmask &= ~(1 << index);
		else:
			status.disabled_bitmask |= 1 << index;
		


	
static func sort_item_toggles(ita:ItemToggle,itb:ItemToggle):
	return ita.item_data.item_id < itb.item_data.item_id

# Called when the node enters the scene tree for the first time.
func _ready():
	var item_buttons = []
	for item in Globals.item_data:
		var it = ItemToggle.new()
		it.status = status
		it.item_data = item
		it.text = item.item_name
		item_buttons.append(it)
		it.pressed = true
		it.disabled = item.item_id == Globals.Items.HPUP
		
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
			
		$"%GridContainer".add_child(it)
		button_grid[current_button_pos_thing] = [it,it.get_path()]
		
		current_button_pos_thing.x += 1
	
	
	for i in button_grid.keys():
		var pos :Vector2 = i
		var toggle : ItemToggle = button_grid[i][0]
		toggle.focus_neighbour_top = get_neighbor_in_dir(button_grid,Vector2.UP,pos,toggle)
		toggle.focus_neighbour_bottom = get_neighbor_in_dir(button_grid,Vector2.DOWN,pos,toggle)	
		
		toggle.focus_neighbour_left = get_neighbor_in_dir(button_grid,Vector2.LEFT,pos,toggle)
		toggle.focus_neighbour_right = get_neighbor_in_dir(button_grid,Vector2.RIGHT,pos,toggle)



	$"%GridContainer".connect_focus_signals()


func get_neighbor_in_dir(
	neighbors:Dictionary,
	dir:Vector2,
	pos:Vector2,
	toggle:ItemToggle
)->String:
	return neighbors.get(pos+dir,[toggle,toggle.get_path()])[1] as String



func toggle_hovered(toggle:ItemToggle):
	#$VBoxContainer/name.text = toggle.text
	$"%desc".text = toggle.item_data.item_desc


func selected():
	show()
	for i in $"%GridContainer".get_children():
		if i.visible:
			
			i.grab_focus()
			break

func deselect():hide()

