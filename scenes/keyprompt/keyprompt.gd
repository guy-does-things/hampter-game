#tool
extends TextureRect

export(String) var act


func _ready():
	SavesManager.settings.connect("changed_setting",self,"setup",[act])
	setup(act)



func setup(action : String):
	if not Globals:return
	var actions := InputMap.get_action_list(action)
	print_debug("WHAT")
	#print_debug()
	#if actions.size() > 0:
	#	$Label.text = Globals.event_to_text((actions[0] as InputEvent))
		
