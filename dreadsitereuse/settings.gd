class_name Settings
extends Reference


enum InputSaveModes{CONTROLLERBUTTON,KEYBOARD,AXIS}
enum ColorBlindModes{NONE,PROTANOPIA,DEUTRANOPIA,TRITANOPIA}

const DEFAUT_KEYS = {
	# movement
	"up":[InputSaveModes.KEYBOARD,KEY_W],
	"down":[InputSaveModes.KEYBOARD,KEY_S],
	"left":[InputSaveModes.KEYBOARD,KEY_A],
	"right":[InputSaveModes.KEYBOARD,KEY_D],

	# actions	
	"jump":[InputSaveModes.KEYBOARD,KEY_K],
	"interact":[InputSaveModes.KEYBOARD,KEY_E],
	"attack":[InputSaveModes.KEYBOARD,KEY_J],
	"show_inv":[InputSaveModes.KEYBOARD,KEY_TAB],
	"platform":[InputSaveModes.KEYBOARD,KEY_SPACE],
	
	# ui
	"ui_accept":[InputSaveModes.KEYBOARD,KEY_SPACE],
	"ui_cancel":[InputSaveModes.KEYBOARD,KEY_ESCAPE],
	
	"settings_left":[InputSaveModes.KEYBOARD,KEY_Q],
	"settings_right":[InputSaveModes.KEYBOARD,KEY_E]
}

const DEFAUT_CONTROLLER = {
	# movement
	"up":[InputSaveModes.CONTROLLERBUTTON,JOY_DPAD_UP],
	"down":[InputSaveModes.CONTROLLERBUTTON,JOY_DPAD_DOWN],
	"left":[InputSaveModes.CONTROLLERBUTTON,JOY_DPAD_LEFT],
	"right":[InputSaveModes.CONTROLLERBUTTON,JOY_DPAD_RIGHT],

	# actions
	"jump":[InputSaveModes.CONTROLLERBUTTON,JOY_XBOX_A],
	"interact":[InputSaveModes.CONTROLLERBUTTON,JOY_R],
	"attack":[InputSaveModes.CONTROLLERBUTTON,JOY_XBOX_X],
	"show_inv":[InputSaveModes.CONTROLLERBUTTON,JOY_START],
	"platform":[InputSaveModes.CONTROLLERBUTTON,JOY_L],
	
	# ui
	"ui_accept":[InputSaveModes.CONTROLLERBUTTON,JOY_XBOX_A],
	"ui_cancel":[InputSaveModes.CONTROLLERBUTTON,JOY_XBOX_B],

	"settings_left":[InputSaveModes.CONTROLLERBUTTON,JOY_L],
	"settings_right":[InputSaveModes.CONTROLLERBUTTON,JOY_R]
}


# actual settings 
var screenshake := 1.0
var master_volume := 1.0
var sfx_volume := 1.0
var music_volume := 1.0
var current_cb_mode := 0
var cur_rend_mode := 0
var current_controller_mappings = DEFAUT_CONTROLLER.duplicate()
var current_keys = DEFAUT_KEYS.duplicate()
var fullscreen = false
var igt = false
var bloom = false
var controller_type = 1
var weaponswap_sound = true
signal changed_setting()





func data2dict()-> Dictionary:
	return {
		"screenshake":screenshake,
		"master_volume":master_volume,
		"sfx_volume":sfx_volume,
		"music_volume":music_volume,
		"current_cb_mode":current_cb_mode,
		"cur_rend_mode":cur_rend_mode,
		"current_keys":current_keys,
		"current_controller_mappings":current_controller_mappings,
		"fullscreen":fullscreen,
		"igt":igt,
		"bloom":bloom,
		"weaponswap_sound":weaponswap_sound,
		"controller_type":controller_type
		

	}
	

func dict2data(data:Dictionary):

	
	sfx_volume = data.get("sfx_volume", 1)
	music_volume = data.get("music_volume", 1)
	master_volume = data.get("master_volume", 1)
	screenshake = data.get("screenshake", 1)
	current_cb_mode = data.get("current_cb_mode", 0)
	cur_rend_mode = data.get("cur_rend_mode", 0)
	current_keys = data.get("current_keys", DEFAUT_KEYS.duplicate())
	current_controller_mappings = data.get("current_controller_mappings", DEFAUT_CONTROLLER.duplicate())
	
	fullscreen = data.get("fullscreen", fullscreen)
	igt = data.get("igt", false)
	bloom = data.get("bloom", true)
	weaponswap_sound = data.get("weaponswap_sound", true)
	controller_type = data.get("controller_type", 1)
	


func change_key(action : String, event : InputEvent):
	if save_event_in_json(action,event):
		update_action(action)
		emit_signal("changed_setting")
		return true
	return false


func save_event_in_json(action :String,ev : InputEvent)-> bool:
	if ev is InputEventJoypadButton:
		current_controller_mappings[action] = [InputSaveModes.CONTROLLERBUTTON,ev.button_index]
		return true
	if ev is InputEventKey:
		current_keys[action] = [InputSaveModes.KEYBOARD,ev.scancode]
		return true
	if (ev is InputEventJoypadMotion):
		if abs((ev as InputEventJoypadMotion).axis_value) < .5:
			return false
			
		current_controller_mappings[action] = [InputSaveModes.AXIS, ev.get_axis(), ev.axis_value]
		return true
		
	return false




static func create_event_from_json(ism : int, code : int, axis_value :=0.0)-> InputEvent:
	match ism:
		InputSaveModes.CONTROLLERBUTTON:
			var thing = InputEventJoypadButton.new()
			thing.button_index = code
			return thing
		InputSaveModes.KEYBOARD:
			var thing = InputEventKey.new()
			thing.scancode = code
			return thing
		InputSaveModes.AXIS:
			var thing = InputEventJoypadMotion.new()
			thing.axis = code
			thing.axis_value = axis_value
			return thing
	
	return null

func load_input():
	for input in DEFAUT_CONTROLLER.keys():
		update_action(input)


func update_action(action_n):
	erase_controls(action_n)
	
	var ctr_a_data = current_controller_mappings[action_n]
	var kbinput = create_event_from_json(InputSaveModes.KEYBOARD,current_keys[action_n][1])
	var ctrinput = create_event_from_json(ctr_a_data[0],ctr_a_data[1],get_arr_element(ctr_a_data,2,0))
	
	InputMap.action_add_event(action_n,kbinput)
	InputMap.action_add_event(action_n,ctrinput)
	
	
	
	
func erase_controls(action_name : String):
	InputMap.action_erase_events(action_name)
	
	
# used for controller elements, saves writing this every time i want the controller's axis 
# if actually saved
func get_arr_element(ar:Array,index:int,defval):
	if index > (ar.size() - 1):return defval
	return ar[index]
	
